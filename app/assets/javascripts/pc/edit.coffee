$ ->
  $('.ajax_add_image').on 'click', ->
    form_text = $('.edit-form').find('#edit-text').val()
    form_image_url =$('.ajax_image_url').val()
    form_image_text =$('.ajax_image_text').val()
    console.log(form_image_url)
    console.log(form_image_text)
    jqXHR = $.ajax({
      async: true
      url: "/recommender/topic_elements/add_image"
      type: 'POST'
      data: "before_text=#{form_text}"
      dataType: 'json'
      cache: false
    })

    jqXHR.done (data, stat, xhr) ->
      console.log("success")
    jqXHR.fail (xhr, stat, err) ->