
library(dplyr)
library(stringr)
library(png)
library(shinyjs)
library(DT)
library(visNetwork)
library(rintrojs)
library(shinydashboard)
library(data.table)



source("carouselPanel.R")

# Panel div for visualization
# override the currently broken definition in shinyLP version 1.1.0
panel_div <- function(class_type, content) {
    div(class = sprintf("panel panel-%s", class_type),
        div(class = "panel-body", content)
    )
}

shinyUI(navbarPage(title = img(src="logo.svg", height = "40px"), id = "navBar",
                   theme = "paper.css",
                   collapsible = TRUE,
                   inverse = TRUE,
                   windowTitle = "Decision Support System for US contracts",
                   position = "fixed-top",
                   footer = includeHTML("./www/include_footer.html"),
                   header = tags$style(
                       ".navbar-right {
                       float: right !important;
                       }",
                       "body {padding-top: 75px;}"),
                   
                   tabPanel("HOME", value = "home",
                            
                            shinyjs::useShinyjs(),
                            
                            tags$head(tags$script(HTML('
                                                       var fakeClick = function(tabName) {
                                                       var dropdownList = document.getElementsByTagName("a");
                                                       for (var i = 0; i < dropdownList.length; i++) {
                                                       var link = dropdownList[i];
                                                       if(link.getAttribute("data-value") == tabName) {
                                                       link.click();
                                                       };
                                                       }
                                                       };
                                                       '))),
                            fluidRow(
                                HTML("
                                     
                                     <section class='banner'>
                                     <h2 class='parallax'>CAREER PATHFINDER</h2>
                                     <p class='parallax_description'>Decision support system to detect whether a sentence in the contract need negotiating</p>
                                     </section>
                                     ")
                                ),
                            
                            # tags$head(includeScript("google-analytics.js")),
                            
                            # A header level row for the title of the app (if needed)  
                            # fluidRow(
                            #     shiny::HTML("<br><br><center> <h1></h1> </center>
                            #                 <br>
                            #                 <br>"),
                            #     style = "height:250px;"),
                            
                            # fluidRow(
                            #     style = "height:250px; padding: 125px 0px;",
                            #     shiny::HTML("<center> <h1>Welcome to the Career PathFinder</h2></center>"),
                            #     shiny::HTML("<center> <h5><i>Like stops on a map, a career path pinpoints your next job, 
                            #                 the job after that, and beyond.</i></h5> </center>")
                            # ),
                            
                            # fluidRow(
                            #     
                            #     style = "height:25px;"),
                            
                            # fluidRow(
                            #     column(2),
                            #     
                            #     column(3,
                            #            div(style="display: inline-block;padding: 100px 0px;",
                            #                HTML("<h3>What <span style='font-weight:bold'>career planning</span> questions are you looking to answer?</h3>")
                            #            )
                            #     ),
                            #     
                            #     column(5,
                            #            
                            #            carouselPanel(
                            #                # tags$a(href = "#FAQ", 
                            #                #        tags$img(src = "screen_capture_absenteeism_2.jpg", width = "615px")), # experiment diff size img - fixed height 1080px and width 1900px
                            #                tags$img(src = "original1.svg", class = "img-responsive center-block"),
                            #                tags$img(src = "original2.svg", class = "img-responsive center-block"),
                            #                tags$img(src = "original3.svg", class = "img-responsive center-block"),
                            #                tags$img(src = "original4.svg", class = "img-responsive center-block"),
                            #                tags$img(src = "original5.svg", class = "img-responsive center-block")
                            #                # tags$a(href = "https://geom.shinyapps.io/word", tags$img(src = "screen_capture_word_2.jpg", width = "615px"))
                            #                
                            #            )
                            #     )
                            # ),
                            # 
                            # fluidRow(
                            #     
                            #     style = "height:50px;"),
                            # 
                            # fluidRow(
                            #     style = "height:250px;",
                            #     shiny::HTML("<center> <h4><i>Are you looking to plan a career with the County?</i></h4> </center>"),
                            #     shiny::HTML("<center> <h4><i>Are you curious about the paths real County employees have taken?</i></h4></center>"),
                            #     shiny::HTML("<center> <h4><i>Then you're in the right place.</i></h4></center>")
                            # ),
                            # 
                            # # PAGE BREAK
                            # tags$hr(),
                            
                            # WHAT
                            fluidRow(
                                column(3),
                                column(6,
                                       shiny::HTML("<br><br><center> <h1>What you'll find here</h1> </center><br>"),
                                       shiny::HTML("<h5>An interactive tool to help you detect the language in the 
                                                   contract is appropriate or not, whether need negotiating, with model
                                                  training behind, you can find which misconduct behaviors belong to which
                                                  catogory, better for you to understand what you encounted, which is 
                                                  meaningful to you.</h5>")
                                       ),
                                column(3)
                                       ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # HOW
                            fluidRow(
                                column(3),
                                column(6,
                                       shiny::HTML("<br><br><center> <h1>How it can help you</h1> </center><br>"),
                                       shiny::HTML("<h5>With most things, the more you know, the better your decisions 
                                                   will be. The Decision support system empowers you to make better decisions 
                                                   when reading the police contracts.</h5>")
                                       ),
                                column(3)
                                       ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # WHERE
                            fluidRow(
                                column(3),
                                column(6,
                                       shiny::HTML("<br><br><center> <h1>Where it came from</h1> </center><br>"),
                                       shiny::HTML("<h5>The data is from all the US contracts, including almost 100 US cities,
                                                   every term in all the 87 documents counts except the stop words.</h5>")
                                       ),
                                column(3)
                                       ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # HOW TO START
                            fluidRow(
                                column(3),
                                column(6,
                                       shiny::HTML("<br><br><center> <h1>How to get started</h1> </center><br>"),
                                       shiny::HTML("<h5>To launch the Decision support system, choose one of the options below. 
                                                   You will not be asked to provide any identifiable information, and 
                                                   you can revisit the Decision support system, to chart a different course 
                                                   for yourself as needs arise.</h5>")
                                       ),
                                column(3)
                                       ),
                            
                            # BUTTONS TO START
                            fluidRow(
                                column(3),
                                column(6,
                                       
                                       tags$div(class = "wrap",
                                                div(class = "center", 
                                                    style="display: inline-block;vertical-align:top; width: 225px;",
                                                    tags$a("I need help finding all the original contracts",
                                                           onclick = "window.open('https://www.checkthepolice.org/database', '_blank')",
                                                           class="btn btn-primary btn-lg")
                                                ),
                                                div(class = "center",
                                                    style="display: inline-block; vertical-align:top; horizontal-align:middle; width: 75px;",
                                                    tags$br(), tags$h4("OR") ),
                                                div(class = "center",
                                                    style="display: inline-block;vertical-align:top; width: 225px;",
                                                    tags$a("I have a sentence in the contract I would like to explore", 
                                                           onclick="fakeClick('careerPF')", 
                                                           class="btn btn-primary btn-lg")
                                                )
                                       )
                                ),
                                column(3)
                            ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # INSTRUCTIONAL SECTION
                            fluidRow(
                                shiny::HTML("<br><br><center> <h1>Decision Support System Made Easy.</h1> </center>
                                            <br>")
                                ),
                            
                            fluidRow(
                                column(3),
                                
                                column(2,
                                       div(class="panel panel-default", 
                                           div(class="panel-body",  width = "600px",
                                               align = "center",
                                               div(
                                                   tags$img(src = "one.svg", 
                                                            width = "50px", height = "50px")
                                               ),
                                               div(
                                                   h5(
                                                       "Pick a sentence."
                                                   )
                                               )
                                           )
                                       )
                                ),
                                column(2,
                                       div(class="panel panel-default",
                                           div(class="panel-body",  width = "600px", 
                                               align = "center",
                                               div(
                                                   tags$img(src = "two.svg", 
                                                            width = "50px", height = "50px")
                                               ),
                                               div(
                                                   h5(
                                                       "Then from that sentence, get the catogories from the sentence."
                                                   )
                                               )
                                           )
                                       )
                                ),
                                column(2,
                                       div(class="panel panel-default",
                                           div(class="panel-body",  width = "600px", 
                                               align = "center",
                                               div(
                                                   tags$img(src = "three.svg", 
                                                            width = "50px", height = "50px")),
                                               div(
                                                   h5(
                                                       "Get more detail regarding the sentence, you can ask for the lawyer and get help based on the categories"
                                                   )
                                               )
                                           )
                                       )
                                ),
                                column(3)
                                
                            ),
                            
                            # Embedded Video from Vimeo on how to use this tool
                            # fluidRow(
                            #     column(3),
                            #     column(6,
                            #            tags$embed(src = "https://player.vimeo.com/video/8419440",
                            #                       width = "640", height = "360") 
                            #     ),
                            #     column(3)
                            # ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            # AFTERWARD
                            # fluidRow(
                            #     column(3),
                            #     column(6,
                            #            shiny::HTML("<br><br><center> <h1>How does it fit in the big picture?</h1> </center><br>"),
                            #            shiny::HTML("<h5>Building a career path is just one part of effective career 
                            #                        planning and development. You should also establish a career plan 
                            #                        to outline <i>how</i> you will achieve your professional goals. Our
                            #                        Career Planning Guide provides information to help you establish 
                            #                        a plan for making your career path a reality.</h5>")
                            #            ),
                            #     column(3)
                            #            ),
                            # 
                            # fluidRow(
                            #     
                            #     style = "height:50px;"),
                            
                            # PAGE BREAK
                            tags$hr(),
                            
                            fluidRow(shiny::HTML("<br><br><center> <h1>Ready to Get Started?</h1> </center>
                                                 <br>")
                            ),
                            fluidRow(
                                column(3),
                                column(6,
                                       tags$div(align = "center", 
                                                tags$a("Start", 
                                                       onclick="fakeClick('careerPF')", 
                                                       class="btn btn-primary btn-lg")
                                       )
                                ),
                                column(3)
                            ),
                            fluidRow(style = "height:25px;"
                            )
                            
                            ), # Closes the first tabPanel called "Home"
                   
                   tabPanel("Decision Support System", value = "careerPF",
                            
                            sidebarLayout( 
                                
                                sidebarPanel( width = 3,
                                              introjsUI(),
                                              
                                              tags$div(
                                                  actionButton("help", "Take a Quick Tour"),
                                                  style = "height:50px;"
                                              ),
                                              useShinyjs(),
                                              
                                              tags$div(
                                                  style = "height:50px;",
                                                  introBox(
                                                      tags$div(
                                                          style = "height:50px;",
                                                          actionLink("settings", "Settings", 
                                                                     icon = icon("sliders", class = "fa-2x"))),
                                                      data.step = 6,
                                                      data.intro = "Settings is where you can set options"
                                                  ),
                                                  radioButtons("selectData", 
                                                               label = "Which data sets do you want to select",
                                                               choices = c("data_sample",
                                                                           "other_data"),
                                                               inline = TRUE,
                                                               width = "100%"
                                                  ),
                                                  # selectizeInput("changeAvatar", "Change Icon:",
                                                  #                choices = c(
                                                  #                            # "Traveler" = "traveler",  # not compatible with new FA
                                                  #                            "Map Marker" = "map-marker", 
                                                  #                            "Rocket" = "rocket", 
                                                  #                            # "Paper Plane" = "paper-plane",  # not compatible with new FA
                                                  #                            "Leaf" = "leaf"),
                                                  #                selected = "rocket"
                                                  # ),
                                                  textInput("userName", "Add your name:", value = ""),
                                                  
                                                  tags$div(
                                                      style = "height:50px;",
                                                      uiOutput("printInput1"),
                                                      uiOutput("printInput2"),
                                                      uiOutput("printInput3"),
                                                      uiOutput("printInput4"),
                                                      uiOutput("printInput5")
                                                  )
                                              )
                                ),  # Closes sidebarPanel
                                mainPanel( width = 8,
                                           fluidRow(
                                               
                                               tags$style(type="text/css",
                                                          ".shiny-output-error { visibility: hidden; }",
                                                          ".shiny-output-error:before { visibility: hidden; }"
                                               ),
                                               introBox(
                                                   panel_div(class_type = "default",
                                                             content = tags$div(
                                                                 uiOutput("displayName"),
                                                                 visNetwork::visNetworkOutput("visTest", height = "20px")
                                                             )
                                                   ),
                                                   data.step = 4,
                                                   data.intro = "Your selections will be displayed here in a graph."
                                               )
                                           ),
                                           fluidRow(
                                               div(class="panel panel-default",
                                                   div(class="panel-body",  width = "600px",
                                                       tags$div(class = "wrap",
                                                                div(class = "left", 
                                                                    style="display: inline-block;vertical-align:top; width: 150px;",
                                                                    uiOutput("stepNo")
                                                                ),
                                                                div(class = "center",
                                                                    style="display: inline-block;vertical-align:top; width: 150px;",
                                                                    introBox(
                                                                        actionButton("goBack", 
                                                                                     label = "Back", 
                                                                                     icon = icon("arrow-circle-left", class = "fa-2x"),
                                                                                     width= "100px", height= "40px"),
                                                                        data.step = 3,
                                                                        data.intro = "Go back a step to edit your selection anytime."
                                                                    )
                                                                ),
                                                                
                                                                
                                                                # div(style="display: inline-block;vertical-align:top; width: 150px;",
                                                                #     uiOutput("clearBtns")
                                                                # ),
                                                                # actionButton("resetBtn", "Reset All", icon = icon("refresh", class = "fa-2x")),    
                                                                div(class = "center",
                                                                    style="display: inline-block;vertical-align:top; width: 150px;",
                                                                    introBox(
                                                                        actionButton("btn1", 
                                                                                     label = "PREDICT", 
                                                                                     icon = icon("arrow-circle-right", class = "fa-2x"),
                                                                                     width= "100px", height= "40px"),
                                                                        data.step = 2,
                                                                        data.intro = "Confirm your selection by clicking here."
                                                                    )
                                                                ),
                                                                
                                                                # actionButton("resetBtn", "Reset All", icon = icon("refresh", class = "fa-2x")),    
                                                                div(class = "center",
                                                                    style="display: inline-block;vertical-align:top; width: 150px;",
                                                                    introBox(
                                                                      actionButton("btn2", 
                                                                                   label = "NEXT", 
                                                                                   icon = icon("arrow-circle-right", class = "fa-2x"),
                                                                                   width= "100px", height= "40px"),
                                                                      data.step = 2,
                                                                      data.intro = "next button"
                                                                    )
                                                                ),
                                                                
                                                       ),
                                                       # Insert Table Output
                                                       introBox(
                                                           uiOutput("btns"),
                                                           data.step = 1, 
                                                           data.intro = "Start by selecting the language from all the contracts."
                                                       ),
                                                       fluidRow(
                                                         sidebarSearchForm(textId = "searchText", buttonId = "searchButton",label = "Search sentences",
                                                                           icon = shiny::icon("search"))
                                                       ),
                                                       body <- dashboardBody(tableOutput("filtered_table"))
                                                   )
                                               ),
                                               plotOutput("myplot")
                                           ),
                                )  # Closes the mainPanel
                            )  # Closes the sidebarLayout
                   ),  # Closes the second tabPanel called "Career PathFinder"
                   
                   tabPanel("ABOUT", value = "about",
                            
                            fluidRow(
                                shiny::HTML("<br><br><center> 
                                            <h1>About Decision Support System</h1> 
                                            <h4>What's behind the data.</h4>
                                            </center>
                                            <br>
                                            <br>"),
                                style = "height:250px;"),
                            fluidRow(
                                div(align = "center",
                                    tags$span(h4("A Brief introduction of Decision Support System"), 
                                              style = "font-weight:bold"
                                    ))
                            ),
                            fluidRow(
                                column(3),
                                column(6,
                                       tags$ul(
                                           tags$li(h6("The system will transfer the complicated contracts into a non-professional readable format and show them in a user-friendly way so that the user can easily find which part of the contract that the police departments in their municipalities use will unfairly take away their rights.")), 
                                           tags$li(h6("This problem is very socially-meaningful because by making the target model, we can alleviate and solve a social problem, which is hard, time consuming, but valuable to people, and worth the difficulty. We also want to learn text mining from such a real problem and try to contribute our own strengths.")), 
                                       )
                                ),
                                column(3)
                            ),
                            fluidRow(
                                column(2),
                                column(8,
                                       # Panel for Background on Data
                                       div(class="panel panel-default",
                                           div(class="panel-body",  
                                               tags$div( align = "center",
                                                         icon("bar-chart", class = "fa-4x"),
                                                         div( align = "center", 
                                                              h5("About the Data")
                                                         )
                                               ),
                                               tags$p(h6("The data is avialable at: https://www.checkthepolice.org/database This dataset is from the “Police Union Contract Project”. This dataset contains the police union contract from the 100 largest U.S. cities.")),
                                               tags$ul(
                                                   tags$li(h6("We are trying to create data mining modules to read the contract files and transform it to user-friendly language in order to answer citizen’s questions about the complaint process. After we are done with data mining modules, we’ll create the intelligent and interactive decision support system that facilitates citizen’s understanding about the complaint process.")),
                                                   tags$li(h6("The police contracts are usually very complicated and hard to understand, for people who is not familiar with the police contract. Having an intelligent interface (a chatbot) which asks which state we are in and what kind of help do we need regarding the complaint process would be very helpful to normal citizens.")),
                                               )
                                           )
                                       ) # Closes div panel
                                ), # Closes column
                                column(2)
                            ),
                            # TEAM BIO
                            fluidRow(
                                column(3),
                                column(6,
                                       shiny::HTML("<br><br><center> <h5>About the team</h5> </center><br>"),
                                       shiny::HTML("<h6>Here is a little information 
                                                   about the project team!</h6>")
                                       ),
                                column(3)
                                       ),
                            
                            fluidRow(
                                
                                style = "height:50px;"),
                            
                            fluidRow(
                                column(3),
                                
                                column(2,
                                       div(class="panel panel-default", 
                                           div(class="panel-body",  width = "600px",
                                               align = "center",
                                               div(
                                                   tags$img(src = "man.svg", 
                                                            width = "50px", height = "50px")
                                               ),
                                               div(
                                                   tags$h5("Zian Wang"),
                                                   tags$h6( tags$i("Model training"))
                                               ),
                                               div(
                                                   ""
                                               )
                                           )
                                       )
                                ),
                                
                                column(2,
                                       div(class="panel panel-default",
                                           div(class="panel-body",  width = "600px", 
                                               align = "center",
                                               div(
                                                   tags$img(src = "woman.svg", 
                                                            width = "50px", height = "50px")
                                               ),
                                               div(
                                                   tags$h5("Sonal Gupta"),
                                                   tags$h6( tags$i("Data preprocessing"))
                                               ),
                                               div(
                                                   ""
                                               )
                                           )
                                       )
                                ),
                                
                                column(2,
                                       div(class="panel panel-default",
                                           div(class="panel-body",  width = "600px", 
                                               align = "center",
                                               div(
                                                   tags$img(src = "woman.svg", 
                                                            width = "50px", height = "50px")),
                                               div(
                                                   tags$h5("Shuo Zheng"),
                                                   tags$h6( tags$i("UI design, data management"))
                                               ),
                                               div(
                                                   ""
                                               )
                                           )
                                       )
                                ),
                                column(3)
                                
                            ),
                            fluidRow(style = "height:150px;")
                                )  # Closes About tab
                   
                            )
        
                   )