#= require active_admin/base
$ ->
  if $('.admin_countries').length
    resource = 'countries'
  else if $('.admin_categories').length
    resource = 'categories'
  else if $('.admin_property_names').length
    resource = 'property_names'
  else if $('.admin_cities').length
    resource = 'cities'
  else if $('.admin_states').length
    resource = 'states'
  else if $('.admin_dimensions').length
    resource = 'dimensions'


  $('input[class=translater]').keypress  (e)->
    if e.which == 13
      $.ajax(
        method : 'PUT'
        url : "/admin/#{resource}/#{e.target.name}/translate"
        data :
          translate : e.target.value
        success : (place)->
          $(e.target).parent().prev().html(place.rus_name)
          $(e.target).parents('tr').find('.col-translate .status_tag').removeClass('no').addClass('yes').text('YES')
          $(e.target).parents('tr').next().find('.translater').focus()
        error : ->
          console.log 'fault'
      )
      e.preventDefault
      return false
