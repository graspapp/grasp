# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  next_steps = $("#concept_progress_next_steps").html()
  error = $("#concept_progress_type_of_error :selected").val()
  options = $(next_steps).filter("optgroup[label='#{error}']").html()
  textarea = $("#concept_progress_action_steps")
  charsRemaining = 140 - textarea.text().length
  
  $(".counter").css "color", (if (charsRemaining < 10) then "red" else "gray")
  
  if charsRemaining == 1
    $(".counter").html charsRemaining+" character remaining"
  else
    $(".counter").html charsRemaining+" characters remaining"
  
  $("#concept_progress_next_steps").html(options) 
  
  $("#concept_progress_mastery_level").change ->
    mastery = $("#concept_progress_mastery_level :selected").val()
    mastery = 1 if mastery < 1
    
    options = $(next_steps).filter("optgroup[label='#{mastery}']").html()
    if options
      $("#concept_progress_next_steps").html(options)      
    else
      $("#concept_progress_next_steps").empty()
    
  $("#concept_progress_action_steps").keyup ->
    charsRemaining = 140 - textarea.val().length
    counter = $(".counter")
    counter.css "color", (if (charsRemaining < 10) then "red" else "gray")
    if charsRemaining == 1
      counter.html charsRemaining+" character remaining"
    else
      counter.html charsRemaining+" characters remaining"
   
$(document).ready(ready)
$(document).on('page:load', ready)