
# Initialize the user selections and tooltip (title)
selections <- vector(mode = "character", length = 0)
edgeLabels <- vector(mode = "character", length = 0)
tips <- vector(mode = "character", length = 0)

# Initialize empty data.frames for nodes and edges
nodes <- data.frame(id = integer(), label = character(), title = character(), 
                    shape = character(), icon.face = character(), icon.code = character(), 
                    color = character(), stringsAsFactors = FALSE)

# Initialize edges data
edges <- data.frame(from = numeric(), to = numeric(), length = numeric())


#Import Data
data_sample <- read.csv("./data/data_sample.csv")
other_data <- read.csv("./data/data_sample.csv")

source("./www/getLink.R")
source("./www/make_breaks.R")

shinyServer(function(input, output, session) {
    
    # Navbar ------------------------------------------------------------------
    shinyjs::addClass(id = "navBar", class = "navbar-right")
    
    # DT Options --------------------------------------------------------------
    options(DT.options = list( lengthMenu = c(10, 20),
                               dom = 'tl'
    ))  # table and lengthMenu options
    
    # Intro JS ----------------------------------------------------------------
    observeEvent(input$help,
                 introjs(session, options = list("nextLabel"="Next",
                                                 "prevLabel"="Back",
                                                 "skipLabel"="Exit"))
    )
    
    # Select dataset -----------------------------------------------------------
    data_set <- reactive({
        switch(input$selectData,
               "data_sample" = data_sample,
               "other_data" = other_data)
    })
    
    # Initialize a variable to count how many times "btn1" is clicked.
    values <- reactiveValues(data = 1) 
    
    # Btn1 ---------------------------------------------------------------------
    # React to "btn1" being pressed by adding 1 to the values$data variable
    observeEvent( input$btn1, {
        if ( input$item_name == "" ) {
            showModal(modalDialog(title = "Choose which sentence you think is same as yours.",
                                  "It looks like you forgot to select a sentence in the contract. Please select a sentence from the drop-down
                                  menu to begin your misconduct detect system",
                                  easyClose = FALSE, size = "s" ))
        } else { 
            values$data = values$data + 1 }
        
    })
    
    # Btn2 ---------------------------------------------------------------------
    # React to "btn2" being pressed by adding 1 to the values$data variable
    observeEvent( input$btn2, {
      if ( input$item_name == "" ) {
        showModal(modalDialog(title = "Choose which sentence you think is same as yours.",
                              "It looks like you forgot to select a sentence in the contract. Please select a sentence from the drop-down
                                  menu to begin your misconduct detect system",
                              easyClose = FALSE, size = "s" ))
      } else { 
        values$data = values$data + 1 }
      
    })
    
    # Go Back Button -----------------------------------------------------------
    
    observeEvent( input$goBack, {
        
        if (values$data <= 5) {
            enable("btn1")
        }
        
        if( values$data == 5 & !is.null(input$select5_rows_selected) ) {
            showModal(
                modalDialog("Please remove your selection before going back.", size = "s",
                            title = "Oops!",
                            footer = modalButton(label = "", icon = icon("close")))
            )
        } else if ( values$data == 4 & !is.null(input$select4_rows_selected) ) {
            showModal(
                modalDialog("Please remove your selection before going back.", size = "s",
                            title = "Oops!",
                            footer = modalButton(label = "", icon = icon("close")))
            )
        } else if ( values$data == 3 & !is.null(input$select3_rows_selected) ) {
            showModal(
                modalDialog("Please remove your selection before going back.", size = "s",
                            title = "Oops!",
                            footer = modalButton(label = "", icon = icon("close")))
            )
        } else if ( values$data == 2 & !is.null(input$select2_rows_selected) ) {
            showModal(
                modalDialog("Please remove your selection before going back.", size = "s",
                            title = "Oops!",
                            footer = modalButton(label = "", icon = icon("close")))
            )
        } else {
            values$data = values$data - 1
        }
    })
    
    output$value <- renderText({ input$caption})
    
    # Disable btn1 when step 5 is reached
    useShinyjs()
    observeEvent( input$btn1, {
        if( values$data == 5 )
            shinyjs::disable("btn1")
    })
    
    # Disable goBack button at start of session
    observe( 
        if(values$data == 1){
            disable("goBack")
        } else {
            enable("goBack")    
        }
    )
    
    # Show/Hide Settings -----------------------------------------------------------------
    # Hide settings at start of new Shiny session
    observe(c(hide("selectData"),
              hide("changeAvatar"),
              hide("userName"),
              hide("download")
    ))
    
    # Toggle visibility of settings
    observeEvent(input$settings, {
        shinyjs::toggle("selectData", anim = TRUE)  # toggle is a shinyjs function
        shinyjs::toggle("changeAvatar", anim = TRUE)
        shinyjs::toggle("userName", anim = TRUE)
    })
    
    # Determine which 'select' options to display (Input choices)
    output$btns <- renderUI({
        if (values$data == 0) {
            return()
        } else if (values$data == 1) {
            uiOutput("select1")
        } else if (values$data == 2) {
            dataTableOutput("select2")
        } else if (values$data == 3) {
            uiOutput("select3")
        } else if (values$data == 4) {
            dataTableOutput("select4")
        } else if (values$data >= 5) {
            textOutput("select5", container=h1)
        } 
    })
    
    # Reset Button -------------------------------------------------------------
    # useShinyjs()
    # observeEvent( input$resetBtn, {
    #     values$data = 1
    #     shinyjs::enable("btn1")
    #     selections <- vector(mode = "character", length = 0)
    # })
    
    # Search NeoGov ------------------------------------------------------------
    link <- eventReactive(input$searchTerm, {
        
        addr <- getLink(input$searchTerm)  # create a hyperlink based on the text input
        
        paste0( "window.open('", addr, "', '_blank')" )  # this code opens the link in a separate window
    })
    
    output$searchNeo <- renderUI({
        actionButton("srchNeo", 
                     label = "Search", 
                     onclick = link(),
                     icon = icon("external-link"))  # when clicked, the link() code executes
    })
    
    # Start Button -------------------------------------------------------------
    observeEvent(input$startBtn, {
        updateNavbarPage(session, "navBar",
                         selected = "careerPF"
        )
    })
    
    # Select Input (Misconduct Behavior) -------------------------------------------------
    output$select1 <- renderUI({
        selectizeInput("item_name", label = "",
                       choices = data_sample$Sentences,
                       width = "100%",
                       options = list(
                           placeholder = 'Select the sentences in the contract you feel confused about',
                           onInitialize = I('function() { this.setValue(""); }'))
        )
    })
    
    # Table Inputs (Next 2-5 Selections) ---------------------------------------
    
    # Table 1 (Step 2)
    # eventReactive( input$item_name,
    top1 <- reactive({
        top <- dplyr::filter(data_set(), data_sample$Sentences == input$item_name) %>%
            select(Sentences, predicted_category)
    })
    
    output$select2 <- DT::renderDataTable({
        datatable( top1(), escape = FALSE,
                   extensions = 'Responsive',
                   selection = list(mode = 'single', target = 'row'),
                   colnames = c("Sentences", "predicted_category"),
                   rownames = FALSE, style = "bootstrap",
                   callback = JS("
                                 var tips = ['Classification Title', 'Title Code', 'Percent of employees that moved into that job from your last selected job',
                                 'Starting salary', 'Difference between the highest possible salaries for the selected jobs',
                                 'Number of employees currently holding the title', 'Link to requirements and description'],
                                 header = table.columns().header();
                                 for (var i = 0; i < tips.length; i++) {
                                 $(header[i]).attr('title', tips[i]);
                                 }
                                 ")
                   )
    })
    
    # outputOptions(output, "select2", suspendWhenHidden = FALSE)
    
    proxy1 = dataTableProxy('select2')
    
    # observeEvent(input$goBack, {
    #     proxy1 <- proxy1 %>% selectRows(NULL)
    #     # values$data <- values$data - 1
    # })
    
    
    # Select Input (step 3) -------------------------------------------------
    output$select3 <- renderUI({
      selectizeInput("item_name", label = "",
                     choices = data_sample$Sentences,
                     width = "100%",
                     options = list(
                       placeholder = 'Select the sentences in the contract you feel confused about',
                       onInitialize = I('function() { this.setValue(""); }'))
      )
    })
    
    
    
    # Table 2 (Step 4)
    top3 <- reactive({
      top <- dplyr::filter(data_set(), data_sample$Sentences == input$item_name) %>%
        select(Sentences, predicted_category)
    })
    
    output$select4 <- DT::renderDataTable({
      datatable( top3(), escape = FALSE,
                 extensions = 'Responsive',
                 selection = list(mode = 'single', target = 'row'),
                 colnames = c("Sentences", "predicted_category"),
                 rownames = FALSE, style = "bootstrap",
                 callback = JS("
                                 var tips = ['Classification Title', 'Title Code', 'Percent of employees that moved into that job from your last selected job',
                                 'Starting salary', 'Difference between the highest possible salaries for the selected jobs',
                                 'Number of employees currently holding the title', 'Link to requirements and description'],
                                 header = table.columns().header();
                                 for (var i = 0; i < tips.length; i++) {
                                 $(header[i]).attr('title', tips[i]);
                                 }
                                 ")
      )
    })
    
    # outputOptions(output, "select2", suspendWhenHidden = FALSE)
    
    proxy2 = dataTableProxy('select4')
    
    
    # Table 4 (Step 5)
    output$select5 <- renderText({
      "You can ask for the lawyear to find help based on the catogories!!"
    })
    
    # outputOptions(output, "select5", suspendWhenHidden = FALSE)
    

    # observeEvent(input$goBack, {
    #     proxy4 <- proxy4 %>% selectRows(NULL)
    #     # values$data <- values$data - 1
    # })
    
    # User name ----------------------------------------------------------------
    plotTitle <- reactive({
        
        if(input$userName == "") {
            paste("Your Contract Decision Making Path")
        } else {
            paste(input$userName, "'s Decision Making Path", sep = "")
        }
    })
    
    
    output$displayName <- renderUI({
        tags$h4( plotTitle() )
        
    })
    
    select_sentence <- reactive({
      if(input$search == data_sample$Sentences) {
        predicted_category <- data_sample[ data_sample$predicted_category == input$predicted_category, "predicted_category"]
      } else {
        predicted_category <- data_sample[ data_sample$predicted_category == input$predicted_category, "predicted_category"]
      }
  })
  
      
    
    
    # Show the current step -------------------
    output$stepNo <- renderUI({
        if(values$data == 1) {
            tags$h4("Step 1:")
        } else if (values$data == 2) {
            # tags$h4("Step 2:")
            div(tags$h4("Step 2:"), div(tags$h6("Show Categories")))
        } else if (values$data == 3) {
            tags$h4("Step 3:")
        } else if (values$data == 4) {
            tags$h4("Step 4:")
        } else if (values$data >= 5) {
            tags$h4("Step 5:")
        }
        
    })
    
    # Get selection data for printing, etc. -----------------------------------
    
    job_1_data <- reactive({
        # Obtain stats
        Sentences <- data_sample[ data_sample$Sentences == input$Sentences, "Sentences"]
        predicted_category <- data_sample[ data_sample$predicted_category == input$predicted_category, "predicted_category"]
        #impact <- data_sample[ data_sample$impact == input$impact, "impact"]
        #Negotiating_Contract <- data_sample[ data_sample$Negotiating_Contract == input$Negotiating_Contract, "Negotiating_Contract"]
        v <- c(input$Sentences, predicted_category) #, impact, Negotiating_Contract)
        v
        
    })
    
    
    example_data <- data_sample$Sentences
    
    # output$filtered_table <- renderTable({
    #   example_data[word %like% input$searchText]
    # })
    
    # top6 <- reactive({
    #   top2 <- dplyr::filter(data_set(), data_sample$Sentences == input$item_name) %>%
    #     select(Sentences, predicted_category)
    # })
    # 
    # output$filtered_table <- DT::renderDataTable({
    #   datatable( top6(), escape = FALSE,
    #              extensions = 'Responsive',
    #              selection = list(mode = 'single', target = 'row'),
    #              colnames = c("Sentences", "predicted_category"),
    #              rownames = FALSE, style = "bootstrap",
    #              callback = JS("
    #                              var tips = ['Classification Title', 'Title Code', 'Percent of employees that moved into that job from your last selected job',
    #                              'Starting salary', 'Difference between the highest possible salaries for the selected jobs',
    #                              'Number of employees currently holding the title', 'Link to requirements and description'],
    #                              header = table.columns().header();
    #                              for (var i = 0; i < tips.length; i++) {
    #                              $(header[i]).attr('title', tips[i]);
    #                              }
    #                              ")
    #   )
    # })
    
    # Print each selection to a panel in sidebar
    output$printInput1 <- renderUI({
        # Display if item is selected
        if(input$item_name == ""){
            return()
        } else {
            div(class="panel panel-default",
                div(class="panel-body",
                    div(tags$img(src = "one.svg", width = "25px", height = "25px"), tags$h6( paste0(input$item_name)),#" (", job_1_data()[2], ")") ),
                        # paste0( job_1_data()[3], " - ", job_1_data()[4]), " /month"), 
                        # div(paste0(job_1_data()[5], " incumbents"))
                    )
                ))
        }
    })
    
    # Create label for output report
    # label_1 <- reactive({
    #     
    #     lab <- paste0( input$item_name, "\n",
    #                    job_1_data()[3], " - ", job_1_data()[4], " Monthly",
    #                    " | ", job_1_data()[5], " Incumbents")
    #     
    #     lab
    # })
    
    # job_2_data <- reactive({
    #     # Obtain stats
    #     itemName <- top1()[ input$select2_rows_selected,  "Item2Name"]
    #     itemNo <- top1()[ input$select2_rows_selected,  "Item2"]
    #     salaryMin <- top1()[ input$select2_rows_selected,  "Salary2Min"] 
    #     salaryMax <- item_ref[ which( itemName == item_ref$TitleLong ), "SalaryMax" ]
    #     incumb <- top1()[ input$select2_rows_selected,  "Incumbents"]
    #     prob <- top1()[ input$select2_rows_selected,  "Prob"]
    #     
    #     salaryMax <- format(salaryMax, big.mark = ",")
    #     salaryMax <- paste0("$", salaryMax)
    #     
    #     salaryMin <- format(salaryMin, big.mark = ",")
    #     salaryMin <- paste0("$", salaryMin)
    #     
    #     prob <- paste0( round( prob*100, 1 ), "%" )
    #     
    #     v <- c(itemName, itemNo, salaryMin, salaryMax, incumb, prob)
    #     
    #     v
    # })
    
    output$printInput2 <- renderUI({
        
        # Display if item is selected
        if( is.null(input$select2_rows_selected) ){
            return()
        } else {
            div(class="panel panel-default",
                div(class="panel-body",
                    div(tags$img(src = "two.svg", width = "25px", height = "25px"), tags$h6( paste0(select2)),#" (", job_1_data()[2], ")") ),
                        # paste0( job_2_data()[3], " - ", job_2_data()[4], " /month"), 
                        # div(paste0(job_2_data()[5], " incumbents"))
                    )
                ))
        }
    })
    
    label_2 <- reactive({
        
        try(
            paste0( job_2_data()[1], "\n",
                    job_2_data()[3], " - ", job_2_data()[4], " Monthly", "\n",
                    job_2_data()[6], " Popularity", " | ", job_2_data()[5], " Incumbents"),
            
            TRUE
        )
        
    })
    
    job_3_data <- reactive({
        # Obtain stats
        itemName <- top2()[ input$select3_rows_selected,  "Item2Name"]
        itemNo <- top2()[ input$select3_rows_selected,  "Item2"]
        salaryMin <- top2()[ input$select3_rows_selected,  "Salary2Min"] 
        salaryMax <- item_ref[ which( itemName == item_ref$TitleLong ), "SalaryMax" ]
        incumb <- top2()[ input$select3_rows_selected,  "Incumbents"]
        prob <- top2()[ input$select3_rows_selected,  "Prob"]
        
        salaryMax <- format(salaryMax, big.mark = ",")
        salaryMax <- paste0("$", salaryMax)
        
        salaryMin <- format(salaryMin, big.mark = ",")
        salaryMin <- paste0("$", salaryMin)
        
        prob <- paste0( round( prob*100, 1 ), "%" )
        
        v <- c(itemName, itemNo, salaryMin, salaryMax, incumb, prob)
        
        v
    })
    
    output$printInput3 <- renderUI({
        
        # Display if item is selected
        if( is.null(input$select3_rows_selected) ){
            return()
        } else {
            div(class="panel panel-default",
                div(class="panel-body",
                    div(tags$img(src = "three.svg", width = "25px", height = "25px"), tags$h6( paste0(job_3_data()[1], " (", job_3_data()[2], ")") ),
                        paste0( job_3_data()[3], " - ", job_3_data()[4], " /month"), 
                        div(paste0(job_3_data()[5], " incumbents"))
                    )
                ))
        }
    })
    
    label_3 <- reactive({
        
        try(
            paste0( job_3_data()[1], "\n",
                    job_3_data()[3], " - ", job_3_data()[4], " Monthly", "\n",
                    job_3_data()[6], " Popularity", " | ", job_3_data()[5], " Incumbents"),
            TRUE
        )
        
    })
    
    job_4_data <- reactive({
        # Obtain stats
        itemName <- top3()[ input$select4_rows_selected,  "Item2Name"]
        itemNo <- top3()[ input$select4_rows_selected,  "Item2"]
        salaryMin <- top3()[ input$select4_rows_selected,  "Salary2Min"] 
        salaryMax <- item_ref[ which( itemName == item_ref$TitleLong ), "SalaryMax" ]
        incumb <- top3()[ input$select4_rows_selected,  "Incumbents"]
        prob <- top3()[ input$select4_rows_selected,  "Prob"]
        
        salaryMax <- format(salaryMax, big.mark = ",")
        salaryMax <- paste0("$", salaryMax)
        
        salaryMin <- format(salaryMin, big.mark = ",")
        salaryMin <- paste0("$", salaryMin)
        
        prob <- paste0( round( prob*100, 1 ), "%" )
        
        v <- c(itemName, itemNo, salaryMin, salaryMax, incumb, prob)
        
        v
    })
    
    output$printInput4 <- renderUI({
        
        # Display if item is selected
        if( is.null(input$select4_rows_selected) ){
            return()
        } else {
            div(class="panel panel-default",
                div(class="panel-body",
                    div(tags$img(src = "four.svg", width = "25px", height = "25px"), tags$h6( paste0(select2)),#" (", job_1_data()[2], ")") ),
                        # paste0( job_4_data()[3], " - ", job_4_data()[4], " /month"), 
                        # div(paste0(job_4_data()[5], " incumbents"))
                    )
                ))
        }
    })
    
    label_4 <- reactive({
        try(
            paste0( job_4_data()[1], "\n",
                    job_4_data()[3], " - ", job_4_data()[4], " Monthly", "\n",
                    job_4_data()[6], " Popularity", " | ", job_4_data()[5], " Incumbents"),
            TRUE
        )
        
    })
    
    job_5_data <- reactive({
        # Obtain stats
        itemName <- top4()[ input$select5_rows_selected,  "Item2Name"]
        itemNo <- top4()[ input$select5_rows_selected,  "Item2"]
        salaryMin <- top4()[ input$select5_rows_selected,  "Salary2Min"] 
        salaryMax <- item_ref[ which( itemName == item_ref$TitleLong ), "SalaryMax" ]
        incumb <- top4()[ input$select5_rows_selected,  "Incumbents"]
        prob <- top4()[ input$select5_rows_selected,  "Prob"]
        
        salaryMax <- format(salaryMax, big.mark = ",")
        salaryMax <- paste0("$", salaryMax)
        
        salaryMin <- format(salaryMin, big.mark = ",")
        salaryMin <- paste0("$", salaryMin)
        
        prob <- paste0( round( prob*100, 1 ), "%" )
        
        v <- c(itemName, itemNo, salaryMin, salaryMax, incumb, prob)
        
        v
    })
    
    # output$printInput5 <- renderUI({
    #     
    #     # Display if item is selected
    #     if( is.null(input$select5_rows_selected) ){
    #         return()
    #     } else {
    #         div(class="panel panel-default",
    #             div(class="panel-body",
    #                 div(tags$img(src = "five.svg", width = "25px", height = "25px"), tags$h6( paste0(job_5_data()[1], " (", job_5_data()[2], ")") ),
    #                     paste0( job_5_data()[3], " - ", job_5_data()[4], " /month"), 
    #                     div(paste0(job_5_data()[5], " incumbents"))
    #                 )
    #             ))
    #     }
    # })
    # 
    # label_5 <- reactive({
    #     
    #     try(
    #         paste0( job_5_data()[1], "\n",
    #                 job_5_data()[3], " - ", job_5_data()[4], " Monthly", "\n",
    #                 job_5_data()[6], " Popularity", " | ", job_5_data()[5], " Incumbents"),
    #         TRUE
    #     )
    # })
    
    # Visualization ------------------------------------------------------------
    
    # Avatar to use in the visualization
    avatar <- reactive({
        switch(input$changeAvatar,
               # "traveler" = "f21d",  # not compatible with new FA
               "map-marker" = "f041",
               "rocket" = "f135",
               # "paper-plane" = "f1d8",  # not compatible with new FA
               "leaf" = "f06c")
    })
    
    colorIcon <- reactive({
        # Automatically change avatar color based on avatar selection
        switch(input$changeAvatar,
               "traveler" = "#0c84e4",      # Blue
               "map-marker" = "#000000",  # Black
               "rocket" = "#f44141",      # Red
               "paper-plane" = "#663096", # Purple  deeper purple --> #663096
               "leaf" = "#10d13a"         # Green
        )
    })
    
    tip1 <- reactive({
        paste0( "<h6>", job_1_data()[1], "</h6>")
        
    })
    
    visNode <- reactive({
        
        item_name1 <- input$item_name  
        item_name2 <- try( top1()[ input$select2_rows_selected,  "Item2Name"], TRUE ) 
        item_name3 <- try( top2()[ input$select3_rows_selected,  "Item2Name"], TRUE ) 
        item_name4 <- try( top3()[ input$select4_rows_selected,  "Item2Name"], TRUE ) 
        item_name5 <- try( top4()[ input$select5_rows_selected,  "Item2Name"], TRUE ) 
        
        # Collect user selections
        selections <- append(selections,
                             c(item_name1, item_name2, item_name3,
                               item_name4, item_name5))
        
        # tips <- append(tips,
        #                c(tip1(), tip2(), tip3(), tip4(), tip5() ))
        
        # Insert line breaks where there's more than 2 words in a title
        selections <- sapply(selections, make_breaks, simplify = "array", USE.NAMES = FALSE)
        
        # Add selections to data.frame
        nodes[1:length(selections),2] <- selections
        
        # # Add tips to data.frame
        # nodes[1:length(tips), 3] <- tips
        
        # Add id
        nodes$id <- 1:length(selections)
        
        # Add icons, which requires defining 3 properties
        nodes$shape <- rep("icon", length(selections))
        nodes$icon.face <- rep('fontAwesome', length(selections))
        nodes$icon.code <- rep(avatar(), length(selections))
        # nodes$color <- rep(colorIcon(), length(selections))  
        # Color is now added via icon options in visNodes()
        
        # Add shadow
        # nodes$shadow <- TRUE
        
        # Keep only the rows that don't have errors
        nodes <- nodes[grep("Error", nodes$label, invert = TRUE),]
        
        # Keep rows that are not NA in Label column
        nodes <- nodes[ !is.na(nodes$label), ]  
        
    })
    
    visEdge <- reactive({
        
        num_selections <- nrow( visNode() )
        
        if ( num_selections > 0)
            for ( i in 1:(num_selections-1) ) {
                edges[i, ] <- c( i, i+1, 200)
            }
        
        edges
    })
    
    # Under Development - Adding popularity percentage to edge label 
    edgeLab <- reactive({
        prob1 <- try( top1()[ input$select2_rows_selected,  "Prob"], TRUE ) 
        prob2 <- try( top2()[ input$select3_rows_selected,  "Prob"], TRUE ) 
        prob3 <- try( top3()[ input$select4_rows_selected,  "Prob"], TRUE ) 
        prob4 <- try( top4()[ input$select5_rows_selected,  "Prob"], TRUE ) 
        
        # Collect user selections
        edgeLabels <- c(prob1, prob2, prob3, prob4)
        
        # Keep only the rows that don't have errors
        edgeLabels <- edgeLabels[grep("Error", edgeLabels, invert = TRUE)]
    })
    
    # Set the seed (layout) for the graph based on number of nodes in graph
    visSeed <- reactive({
        if( nrow(visNode()) == 1 ) {
            1
        } else if ( nrow(visNode()) == 2 ) {
            6
        } else if ( nrow(visNode()) == 3 ) {
            21
        } else if ( nrow(visNode()) == 4 ) {
            30
        } else if ( nrow(visNode()) == 5 ) {
            5432
        }
    })
    
    # Creating the dynamic graph
    output$visTest <- visNetwork::renderVisNetwork({
        
        # The below uses a different random seed to determine layout based on num of nodes
        
        visNetwork::visNetwork(visNode(), visEdge(), height = "275px", width = "100%") %>%
            addFontAwesome() %>%
            visNetwork::visEdges(dashes = TRUE, shadow = TRUE,
                                 arrows = list(to = list(enabled = TRUE, scaleFactor = 2)),
                                 color = list(color = "#587fb4", highlight = "red")) %>%
            visNodes(shadow = list(enabled = TRUE, size = 15),
                     icon = list( color = colorIcon() )) %>%
            visLayout(randomSeed = visSeed() ) %>%
            visPhysics(solver = "barnesHut", stabilization = list(enabled = FALSE))
    })
    
})