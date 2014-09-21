# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  data = $("#cp_chart").data()

  $("#cp_chart").highcharts
    
    chart:
      marginTop: 100
        
    credits:
      false
      
    title:
      text: ""
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
      data: data.conceptProgress.map (cp) -> cp.mastery 
      nextStep: data.conceptProgress.map (cp) -> cp.next_step},
      {
      name: "Effort Level"
      data: data.conceptProgress.map (cp) -> cp.effort }]
      
    tooltip:
      shared: true
      style:{
        width: 400;
      }
      formatter: ->
        index = this.points[0].point.x
        step = this.points[0].series.options.nextStep
        
        s = this.x + "<br>"
        $.each this.points, ->
          s +=  this.series.name + ": " + this.y + "<br>"
          return
          
        s += "Next Steps: <b>\"" + step[index] + "\"</b>"
        return s
        
$(document).ready(ready)
$(document).on('page:load', ready)