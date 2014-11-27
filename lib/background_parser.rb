class BackgroundParser
  def parser

    ActiveRecord::Base.connection_pool.with_connection do

      begin

        # парсим страны
        Log.create! level: :info, text: 'Парсим страны'

        doc = Nokogiri::HTML(open(URI.encode('http://www.weatherbase.com/weather/countryall.php3')))

        doc.css('#row-nohover li a').each do |country_node|

          country_name = country_node.content
          country_href = country_node.attr('href')
          country_href = 'http://www.weatherbase.com' + country_href

          country = Country.find_by_name country_name

          if country.nil?

            Country.create! name: country_name, href: country_href

          end

        end

      rescue Exception => e
        Log.create! level: :error, text: 'Что то сломалось при парсинге стран', stack_trace: e.backtrace.inspect
      end

      # Парсим города и штаты

      Log.create! level: :info, text: 'Парсим города и страны'

      Country.find_each do |country|

        begin

          p country.href
          doc = Nokogiri::HTML(open(URI.encode(country.href)))

          if country.href =~ /.*\/weather\/state\.php3.*/
            part_entity = State
          else
            part_entity = City
          end

          doc.css('#row-nohover li a').each do |part_node|

            part_name = part_node.content
            part_href = part_node.attr('href')
            part_href = ('http://www.weatherbase.com' + part_href).gsub('/weather/weather.php3', '/weather/weatherall.php3')

            part = part_entity.find_by_name part_name

            if part.nil?

              part = part_entity.create! name: part_name, href: part_href, part_place: country

            end

          end

        rescue Exception => e
          Log.create! level: :error, text: 'Что то сломалось при парсинге городов или штатов', stack_trace: country.href
        end

      end

      # парсим города в штатах

      Log.create! level: :info, text: 'Парсим города в штатах'

      State.find_each do |state|
        begin

          doc = Nokogiri::HTML(open(URI.encode(state.href)))

          doc.css('#row-nohover li a').each do |city_node|

            city_name = city_node.content
            city_href = city_node.attr('href')
            city_href = ('http://www.weatherbase.com' + city_href).gsub('/weather/weather.php3', '/weather/weatherall.php3')

            city = City.find_by_name city_name

            if city.nil?

              City.create! name: city_name, href: city_href, part_place: state

            end

          end

        rescue Exception => e
          Log.create! level: :error, text: 'Что то сломалось при парсинге городов в штате', stack_trace: e.backtrace.inspect
        end
      end


      #   парсим данные

      Log.create! level: :info, text: 'Парсим пропертя'

      City.find_each do |city|
        begin

          doc = Nokogiri::HTML(open(URI.encode(city.href)))

          property_name = nil
          category = nil
          doc.css('#left-weather-content > *').each_with_index { |node, index|
            unless index.zero?

              if node.attr('id') == 'headerfont'

                category_name = node.content

                category = Category.find_by_name category_name

                if category.nil?

                  category = Category.create! name: category_name

                end

              elsif node.attr('class') == 'weather-table'

                property_name_name = node.css('#h4font').first.content

                property_name = PropertyName.find_by_name property_name_name

                if property_name.nil?

                  property_name = PropertyName.create! name: property_name_name, category: category

                end

              elsif node.attr('width') == '650'

                node_content = node.css('[bgcolor=white]').first

                dimension_name = node_content.css('.dataunit').first.content


                dimension = Dimension.find_by_name dimension_name

                if dimension.nil?

                  dimension = Dimension.create! name: dimension_name

                end

                if property_name.dimension.nil?
                  property_name.dimension = dimension
                  property_name.save!
                end

                data = node_content.css('.data').map(&:content).join('|')

                PropertyPosition.create! values: data, city: city, property_name: property_name

              end

            end
          }

        rescue Exception => e
          Log.create! level: :error, text: 'Что то сломалось при парсинге пропертей', stack_trace: city.href
        end
      end

      Log.create! level: :info, text: 'Конец парсинга'

    end

  end

  handle_asynchronously :parser

end