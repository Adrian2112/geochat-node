window.geochat = {}

#setea los attributos de location
lat = null
lon = null
success = (position) ->
  lat = position.coords.latitude
  lon = position.coords.longitude

  console.log("lat #{lat}")
  console.log("lon #{lon}")
  foursquare_api()

error = () ->
    "error gelocation"

navigator.geolocation.getCurrentPosition(success, error)

#peticion de lugares a foursqueare
foursquare_api = (params) ->
  if typeof params != typeof {}
    params = {}

  api_params = {
    client_id: "IHMMPIGOYA2LOITCNDCUFNTHWLERW0MLTGB2CGINJCZT03V4"
    client_secret: "OVSYIKEBFTRPYCVBDBT0LMHO3I23Z0JIHOQTBYZ02YPFLOQD"
    v: moment().format("YYYYmmdd")
    limit: 20
    ll: "#{lat},#{lon}"
  }
  $.extend(api_params,params)
  
  $.ajax({
    url: "https://api.foursquare.com/v2/venues/search"
    data: api_params
    dataType: "json"
    beforeSend: ->
      $("#places").html("<img src='/images/spinner.gif' />")
    success: (data) ->
      window.geochat.places = $.map data.response.venues, (e, i) ->
        {name: e.name, id: e.id}
      refresh_places(window.geochat.places)
  })

refresh_places = (places) ->
  html = Handlebars.compile($("#places_tmpl").html())
  $("#places").html(html({places: places}))

jQuery ->

  $("form#place_query input.query").observe_field 0.5, ->
    places = geochat.places || []
    query = this.value
    re = new RegExp(query, "i")
    
    matched_places = $.map places, (e,i) ->
      if e.name.match(re) then e else null

    if matched_places.length != 0 and query != ""
      refresh_places(matched_places)
    else
      foursquare_api({query: query})

   $("form#place_query").submit ->
     foursquare_api({query: $(this).children(".query").val()})
     return false
