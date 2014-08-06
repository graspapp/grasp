# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  data = $("#concept_progress_chart").data()

  $("#concept_progress_chart").highcharts
    title:
      text: "Your Progress"
      x: -20 #center

    xAxis:
      title:
        text: "Date"
      categories: data.conceptProgress.map (cp) -> cp.date

    yAxis:
      title:
        text: "Learning"
      min: 0
      max: 4

    plotLines: [
      value: 0
      width: 1
      color: "#808080"
    ]
       
    legend:
      layout: "vertical"
      align: "right"
      verticalAlign: "middle"
    
    
    series: [{
      name: "Mastery Level"
      data: data.conceptProgress.map (cp) -> cp.mastery },
      
      {name: "Effort Level"
      data: data.conceptProgress.map (cp) -> cp.effort }
      
      ]

$(document).ready(ready)
$(document).on('page:load', ready)