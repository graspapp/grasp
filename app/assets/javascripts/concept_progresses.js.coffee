# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  next_steps = $('#concept_progress_next_steps').html()
  error = $('#concept_progress_type_of_error :selected').val()
  options = $(next_steps).filter("optgroup[label='#{error}']").html()
  $('#concept_progress_next_steps').html(options)      
  
  
  $('#concept_progress_type_of_error').change ->
    error = $('#concept_progress_type_of_error :selected').val()
    options = $(next_steps).filter("optgroup[label='#{error}']").html()
    if options
      $('#concept_progress_next_steps').html(options)      
    else
      $('#concept_progress_next_steps').empty()
    
      
$(document).ready(ready)
$(document).on('page:load', ready)