source("./src/config/index.R")

ui <- tags$html(
  tags$head(
    useShinyjs(),

    tags$link(
      href = "https://fonts.googleapis.com/css2?family=PT+Sans+Narrow:wght@400;700&display=swap",
      rel = "stylesheet"
    ),

    tags$link(
      href = "https://fonts.googleapis.com/css2?family=Rajdhani&display=swap",
      rel = "stylesheet"
    ),

    tags$style(sass(sass_file("./src/styles/main.scss"),
      options = sass_options(output_style = "expanded"),
      output = "./src/styles/styles.css"
    )),

    tags$link(rel = "icon", href = "./assets/logos/shortLogo.png"),
    tags$meta(name = "description", content = "Plot Factory"),
    tags$meta(charset = "utf-8"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$title("Plot Factory"),

    includeScript("./scripts/reload.js")
  ),
  tags$body(
    router_ui()
  )
)

server <- function(input, output, session) {
  router(input, output, session)

  session$userData$dataframe <- reactiveValues(
    data = NULL
  )

  session$userData$plotOptions <- reactiveValues(
    type = NULL,
    x = NULL,
    y = NULL,
    groupBy = NULL,
    title = NULL,
    subtitle = NULL,
    hexColor = "#FFFFFF",
    typeColor = NULL
  )

  session$userData$plotConfig <- reactiveValues(
    subtitles = TRUE,
    fixedRange = FALSE
  )
}

options(shiny.port = 3333)
shinyApp(ui, server)