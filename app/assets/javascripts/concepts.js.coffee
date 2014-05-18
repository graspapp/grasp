# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  
  $("#concept_progress_chart").highcharts
    title:
      text: "Your Progress"
      x: -20 #center

    xAxis:
      title:
        text: "Date"
      categories: [ "Jan", "Feb", "Mar", "Apr" ]

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
      name: "Goal Level"
      data: [ 1, 3, 2, 4]},
      
      {name: "Mastery Level"
      data: [1, 4, 4, 2]}
      
      {name: "Effort"
      data: [2, 2, 3, 4]}
      
      ]

$(document).ready(ready)
$(document).on('page:load', ready)