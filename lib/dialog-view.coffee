module.exports =
  class DialogView

    constructor: () ->

      @count = 0
      @toAppend = ""

      # Create root element
      @element = document.createElement('div')
      @element.classList.add('dialog')

      header = document.createElement('h1')
      header.textContent = 'Compile Options'
      header.classList.add('header','compile-options','block')
      @element.appendChild(header)

      @body = document.createElement('div')
      @body.classList.add('dialog-body','block')
      @body.setAttribute("id","body")
      @element.appendChild(@body)

      ###
      input1  = document.createElement('input')
      input1.placeholder = "Enter compile option"
      input1.setAttribute('id','input1')
      input1.classList.add('compile-option','input1')
      input1.addEventListener("keydown", (event)->
        e = document.getElementById(input1.id)
        console.log "id is " + e.id
        value = e.value
        console.log "value is " + value
        console.log "key code is " + event.keyCode
        if event.keyCode == 8
          e.value = value.substring(0,value.length-1)
          )
      body.appendChild(input1)

      input2  = document.createElement('input')
      input2.placeholder = "Enter arguments for this option"
      input2.setAttribute('id','input2')
      input2.classList.add('compile-option','input2')
      input2.addEventListener("keydown", (event)->
        e = document.getElementById(input2.id)
        console.log "id is " + e.id
        value = e.value
        console.log "value is " + value
        console.log "key code is " + event.keyCode
        if event.keyCode == 8
          e.value = value.substring(0,value.length-1)
        )
      body.appendChild(input2)

      span = document.createElement('span')
      span.classList.add('icon', 'icon-file-add')
      span.addEventListener('click', -> console.log "add new line of inputs")
      body.appendChild(span)
      ###

      @makeInput(@body)

      footer = document.createElement('div')
      footer.classList.add('dialog-footer','block')
      @element.appendChild(footer)

      button1 = document.createElement('button')
      button1.textContent = "Compile"
      button1.setAttribute('id','btn1')
      button1.classList.add('btn', 'btn-success', 'inline-block-tight','block','compile-button','btn-lg','button1')
      button1.addEventListener('click',@clicked)
      footer.appendChild(button1)

      button2 = document.createElement('button')
      button2.textContent = "Cancel"
      button2.setAttribute('id','btn2')
      button2.classList.add('btn', 'btn-warning', 'inline-block-tight','block','compile-button','btn-lg','button2')
      button2.addEventListener('click',@clicked)
      footer.appendChild(button2)



    makeInput: (body)->

      div = document.createElement("div")
      div.classList.add("block")

      input1  = document.createElement('input')
      input1.placeholder = "Enter compile option"
      input1.setAttribute('id','input' + @count)
      input1.classList.add('compile-option','input1',@count + "")
      input1.addEventListener("keyup", (event)->
        #e = document.getElementById(input1.id)
        console.log "id is " + input1.id
        value = input1.value
        console.log "value is " + value
        console.log "key code is " + event.keyCode
        if event.keyCode == 8
          input1.value = value.substring(0,value.length-1)
          )
      div.appendChild(input1)

      input2  = document.createElement('input')
      input2.placeholder = "Enter arguments for this option"
      input2.setAttribute('id','input' + @count)
      input2.classList.add('compile-option','input2',@count + "")
      input2.addEventListener("keyup", (event)->
        #e = document.getElementById(input2.id)
        console.log "id is " + input2.id
        value = input2.value
        console.log "value is " + value
        console.log "key code is " + event.keyCode
        if event.keyCode == 8
          input2.value = value.substring(0,value.length-1)
        )
      div.appendChild(input2)

      @count++ # increment count

      span = document.createElement('span')
      span.classList.add('icon', 'icon-file-add')
      span.addEventListener('click',@addNewInputs)
      div.appendChild(span)

      body.appendChild(div)
      console.log "appended div to body"


    get: (id) ->
      return document.getElementById(id)


    addNewInputs: =>
      #console.log "body is " + @body
      @makeInput(@body)

    clicked: (e) =>
      #console.log "Clicked method is called"
      console.log "to append is " + @toAppend
      #if e == undefined
      #  return false
      # e is the event.
      Sysj = require './sysj'
      Sysj.clickHappened = true
      id =  e.target.id;

      console.log "count is " + @count

      if id == 'btn1'
        i = 0
        while i < @count
          inputs = document.getElementsByClassName(i + "")
          j=0
          while j<2
            console.log "input j is " + inputs[j].value
            if @toAppend != ""
              @toAppend = @toAppend + " " + inputs[j].value
            else
              @toAppend = inputs[j].value
            j++
          i++

        console.log "to append is now" + @toAppend

        #compile
        #return "compile"
        Sysj.getModalPanel().destroy()
        Sysj.compile(@toAppend)
        console.log "compile"
      else if id == 'btn2'
        Sysj.getModalPanel().destroy()
        console.log "closed compile dialog"
        #return "close"
        # close the modal
      else
        Sysj.getModalPanel().destroy()
        console.log "we have a problem and id is " + id


    # Returns an object that can be retrieved when package is activated
    serialize: ->

    # Tear down any state and detach
    destroy: ->
      @element.remove()

    getElement: ->
      @element
