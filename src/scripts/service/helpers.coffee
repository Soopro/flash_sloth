angular.module 'flashSloth'

# formSubmitValidation
.service 'fsv', ->
  (form)->
    if not form
      console.error form, "Form is not exist"
      return false
    if not form.$valid
      args=[]
      for arg in arguments
        args.push arg
      for arg in args[1..]
        if form[arg]
          form[arg].$touched = true
          form[arg].$dirty = true
        else
          console.warn "Form Submit Validation Service Error: "+
                        "'"+arg+"' is undefined"
      return false
    else
      return true