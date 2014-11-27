ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel 'Панель управления' do
          strong { link_to 'Запустить анализ', admin_dashboard_start_analyze_path, remote: true }
        end
      end

      column do

        panel 'Логи' do

          section {
            strong { link_to 'Обновить', admin_root_path }
            strong { link_to 'Очистить лог', admin_dashboard_clear_log_path }
          }

          Log.find_each do |log|
            div class: 'log_'+log.level do
              strong { log.id }
              strong { log.text }
              strong class: :float_right do
                log.created_at.strftime('%F %T')
              end
            end
          end

        end

      end
    end
  end # content



  page_action :start_analyze, method: :get do

    parser = BackgroundParser.new
    parser.parser

    head :ok

  end

  page_action :clear_log, method: :get do

    Log.delete_all
    redirect_to admin_root_url

  end

end
