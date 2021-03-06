#ui.R
library(shiny)
library(plotly)
library(leaflet)
library(dplyr)
library(shinythemes)


navbarPage(title = "The Opioid Crisis in America", id = "inTabset", collapsible = TRUE,  fluid = TRUE,
           
           theme = shinytheme("darkly"),
           
           tabPanel(
             title = "Picture1", 
             value = "tab0",
             column(3,offset=5,actionButton(inputId = "toTab1_0", label = "Next"),
                    actionButton(inputId = "toTab7_0", label = "End")),
             br(),br(),
             img(src='pic1.png', height="600px", width="900px",align="center",
                 style="display: block; margin-left: auto; margin-right: auto;"),
             p("© James Nachtwey, TIME Magazine, The Opioid Diaries")
           ),
           
           tabPanel(
             title = "Crisis Through Time", 
             value = "tab1",
             actionButton(inputId = "beginning1", label = "Start"),
             actionButton(inputId = "toTab2_1", label = "Next"),
             actionButton(inputId = "toTab7_1", label = "End"),
             tags$h1("Deaths by Age Group 1999 - 2016"),
             plotlyOutput(outputId = "plot1"),
             tags$h1("Deaths by Race 1999-2016"),
             plotlyOutput(outputId = "plot1_2"),
             tags$h1("Deaths by Gender 1999-2016"),
             plotlyOutput(outputId = "plot1_3")
           ),
           
           tabPanel(
             title = "Age Groups Affected", 
             value = "tab2",
             actionButton(inputId = "beginning2", label = "Start"),
             actionButton(inputId = "toTab1_1", label = "Previous"),
             actionButton(inputId = "toTab3_1", label = "Next"),
             actionButton(inputId = "toTab7_2", label = "End"),
             tags$h1("Age Groups By Total Deaths"),
             sliderInput(inputId = "yearChoice_1", label = "Choose Year to Plot:", min = 1999, max = 2016, value = 1999, width = "500px", animate = TRUE, sep = ""),
             selectInput(inputId = "input1_1",
                         label = "Choose Type of Death:",
                         choices = c("Unintentional" = "Drug poisonings (overdose) Unintentional (X40-X44)",
                                     "Other" = "All other drug-induced causes",
                                     "Suicide" = "Drug poisonings (overdose) Suicide (X60-X64)",
                                     "Undetermined" = "Drug poisonings (overdose) Undetermined (Y10-Y14)")),
             plotlyOutput(outputId = "plot2_1"),
             tags$h1("Races By Total Deaths"),
             sliderInput(inputId = "yearChoice_2", label = "Choose Year to Plot:", min = 1999, max = 2016, value = 1999, width = "500px", animate = TRUE, sep = ""),
             selectInput(inputId = "input1_2",
                         label = "Choose Type of Death:",
                         choices = c("Unintentional" = "Drug poisonings (overdose) Unintentional (X40-X44)",
                                     "Other" = "All other drug-induced causes",
                                     "Suicide" = "Drug poisonings (overdose) Suicide (X60-X64)",
                                     "Undetermined" = "Drug poisonings (overdose) Undetermined (Y10-Y14)")),
             plotlyOutput(outputId = "plot2_2"),
             tags$h1("Gender By Total Deaths"),
             sliderInput(inputId = "yearChoice_3", label = "Choose Year to Plot:", min = 1999, max = 2016, value = 1999, width = "500px", animate = TRUE, sep = ""),
             selectInput(inputId = "input1_3",
                         label = "Choose Type of Death:",
                         choices = c("Unintentional" = "Drug poisonings (overdose) Unintentional (X40-X44)",
                                     "Other" = "All other drug-induced causes",
                                     "Suicide" = "Drug poisonings (overdose) Suicide (X60-X64)",
                                     "Undetermined" = "Drug poisonings (overdose) Undetermined (Y10-Y14)")),
             plotlyOutput(outputId = "plot2_3")
           ),
           
           tabPanel(
             title = "Where?",
             value = "tab3",
             actionButton(inputId = "beginning3", label = "Start"),
             actionButton(inputId = "toTab2_2", label = "Previous"),
             actionButton(inputId = "toTab3.5_1", label = "Next"),
             actionButton(inputId = "toTab7_3", label = "End"),
             tags$h1("Map of Top Counties Affected By Crisis"),
             sliderInput(inputId = "numObs1", label = "Number of Counties to Plot:", min = 5, max = 3000, value = 1000, width = "850px"),
             selectInput(inputId = "deathChoice",
                         label = "Choose type of death:",
                         choices = c("Unintentional" = "Drug poisonings (overdose) Unintentional (X40-X44)",
                                     "Other" = "All other drug-induced causes",
                                     "Suicide" = "Drug poisonings (overdose) Suicide (X60-X64)",
                                     "Undetermined" = "Drug poisonings (overdose) Undetermined (Y10-Y14)")),
             sliderInput(inputId = "yearChoice", label = "Choose Year to Plot:", min = 1999, max = 2016, value = 1999, width = "500px", animate = TRUE, sep = ""),
             leafletOutput(outputId = "plot3", width = "100%", height = "600px"),
             tags$h1("Table of Top Counties Arranged By Total Deaths"),
             dataTableOutput(outputId = "table1")
           ),
           
           tabPanel(
             title = "Picture2", 
             value = "tab3.5",
             column(3,offset=5,actionButton(inputId = "beginning3.5", label = "Start"),
                    actionButton(inputId = "toTab3_2", label = "Previous"),
                    actionButton(inputId = "toTab4_1", label = "Next"),
                    actionButton(inputId = "toTab7_4", label = "End")),
             br(),br(),
             img(src='pic2.png', height="600px", width="900px",align = "center",
                 style="display: block; margin-left: auto; margin-right: auto;"),
             p("© James Nachtwey, TIME Magazine, The Opioid Diaries")
           ),
           
           tabPanel(
             title = "Looking at States", 
             value = "tab4",
             sidebarLayout(position = "right",
                           sidebarPanel(h3("Breakdown by state"),
                                        width = 3, 
                                        selectInput(inputId = "Select State",
                                                    label = "Select State",
                                                    choices = c("Alabama",
                                                                "Alaska",
                                                                "Arizona",
                                                                "Arkansas",
                                                                "California",
                                                                "Colorado",
                                                                "Connecticut",
                                                                "Delaware",
                                                                "Florida",
                                                                "Georgia",
                                                                "Hawaii",
                                                                "Idaho",
                                                                "Illinois",
                                                                "Indiana",
                                                                "Iowa",
                                                                "Kansas",
                                                                "Kentucky",
                                                                "Louisiana",
                                                                "Maine",
                                                                "Maryland",
                                                                "Massachusetts",
                                                                "Michigan",
                                                                "Minnesota",
                                                                "Mississippi",
                                                                "Missouri",
                                                                "Montana",
                                                                "Nebraska",
                                                                "Nevada",
                                                                "New Hampshire",
                                                                "New Jersey",
                                                                "New Mexico",
                                                                "New York",
                                                                "North Carolina",
                                                                "North Dakota",
                                                                "Ohio",
                                                                "Oklahoma",
                                                                "Oregon",
                                                                "Pennsylvania",
                                                                "Rhode Island",
                                                                "South Carolina",
                                                                "South Dakota",
                                                                "Tennessee",
                                                                "Texas",
                                                                "Utah",
                                                                "Vermont",
                                                                "Virginia",
                                                                "Washington",
                                                                "West Virginia",
                                                                "Wisconsin",
                                                                "Wyoming"))
                           ),
                           
                           mainPanel(
                             actionButton(inputId = "beginning4", label = "Start"),
                             actionButton(inputId = "toTab3.5_2", label = "Previous"),
                             actionButton(inputId = "toTab5_1", label = "Next"),
                             actionButton(inputId = "toTab7_5", label = "End"),
                             tags$h1("Crude death rates over time (by state)"),
                             plotlyOutput(outputId = "deathrates" 
                             )
                           ))),
           
           tabPanel(
             title = "Looking at prescribers",
             value = "tab5",
             sidebarLayout(position = "right",
                           sidebarPanel(h3("Breakdown by state"),
                                        width = 3, strong("Highest opioids prescribers :"),
                                        p("1. Assistant podiatrics - 55.6%"),
                                        p("2. Nursing facilities - 23.7 %"), p("3. Cardiovascular technologists - 8%"), 
                                        p("4. Opticians - 4.7%"),br(),
                                        strong("States with high average opioid prescriptions :"),
                                        p("1. Utah - 14.2%"),
                                        p("2. Tennessee - 12.9%"),
                                        p("3. Alabama - 11.7%"),
                                        p("4. Colorado - 11.6%")),
                           mainPanel(actionButton(inputId = "beginning5", label = "Start"),
                                     actionButton(inputId = "toTab4_2", label = "Previous"),
                                     actionButton(inputId = "toTab6_1", label = "Next"),
                                     actionButton(inputId = "toTab7_6", label = "End"),
                                     tags$h1("Death rates and prescriptions in 2014"),
                                     plotlyOutput(outputId = "map",height = "500px" ,width = "800px"))
             )
           ),
           
           tabPanel(
             title = "Breakdown",
             value = "tab6",
             sidebarLayout(position = "right",
                           sidebarPanel(h3("Breakdown by state"),
                                        width = 3,selectInput(inputId = "Sex",
                                                              label = "Sex",
                                                              choices = c("Male","Female","Both Sexes")),
                                        selectInput(inputId = "Age",
                                                    label = "Age",
                                                    choices = c("0–14","15–24","25–34","35–44","45–54","55–64","65–74",
                                                                "75+","All Ages"))),
                           mainPanel(actionButton(inputId = "beginning6", label = "Start"),
                                     actionButton(inputId = "toTab5_2", label = "Previous"),
                                     actionButton(inputId = "toTab7_7", label = "End"),
                                     tags$h1("Country level statistics"),
                                     plotlyOutput(outputId = "brkdn")))
           ),
           
           tabPanel(
             title = "Picture3", 
             value = "tab7",
             column(3,offset=5,actionButton(inputId = "beginning7", label = "Start"),
                    actionButton(inputId = "toTab6_2", label= "Previous")),
             br(),br(),
             img(src='pic3.png', height="600px", width="900px",align="center", 
                 style="display: block; margin-left: auto; margin-right: auto;"),
             p("© James Nachtwey, TIME Magazine, The Opioid Diaries")
           )
           
)
