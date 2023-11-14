# Load necessary libraries from tidyverse
library(dplyr)
library(stringr)

# Function to parse VTT file and convert to dataframe
parse_vtt_to_dataframe <- function(file_path) {
  # Read the file lines
  lines <- readLines(file_path)
  
  # Initialize variables to store the extracted data
  time_begin <- c()
  time_end <- c()
  speaker <- c()
  content <- c()
  
  # Iterate over the lines to extract data
  for (i in 1:(length(lines) - 1)) {
    # Check if the line contains time stamps
    if (str_detect(lines[i], "-->")) {
      # Extract time stamps
      times <- str_extract_all(lines[i], "[0-9]{2}:[0-9]{2}:[0-9]{2}\\.[0-9]{3}")[[1]]
      time_begin <- c(time_begin, times[1])
      time_end <- c(time_end, times[2])
      
      # Extract speaker and content from the next line
      speaker_content <- str_match(lines[i + 1], "<v ([^>]+)>(.*)")
      speaker <- c(speaker, speaker_content[2])
      content <- c(content, speaker_content[3])
    }
  }
  
  # Create a dataframe
  tibble(
    time_begin,
    time_end,
    speaker,
    content)

}

# Path to the VTT file
file_path <- "/Projects/file_name.vtt"

parsed_vtt <- parse_vtt_to_dataframe(file_path)

# Use mutate combined with gsub to remove the "</v>" string from the content variable
parsed_vtt <- parsed_vtt %>%
  mutate(content = gsub("</v>", "", content))


# Define a function to identify groups of consecutive rows with the same speaker
find_consecutive_groups <- function(speaker) {
  # Create a lagged version of the 'speaker' column
  lag_speaker <- lag(speaker)
  
  # Identify changes in speaker and create group IDs for consecutive rows
  cumsum(speaker != lag_speaker | is.na(lag_speaker))
}

# Apply the function to parsed_vtt and transform the data
parsed_vtt_transformed <- parsed_vtt %>%
  # Generate group IDs for consecutive same speakers
  mutate(group_id = find_consecutive_groups(speaker)) %>%
  # Group by the generated group ID and speaker
  group_by(group_id, speaker) %>%
  # Summarise the data: find the first time_begin, last time_end, and concatenate content
  summarise(
    time_begin = first(time_begin),
    time_end = last(time_end),
    content = paste(content, collapse = " "),
    .groups = 'drop'
  ) %>%
  # Remove the auxiliary group_id column
  select(-group_id)

# Create a script to add a variable called "duration"
parsed_vtt_transformed <- parsed_vtt_transformed %>%
  mutate(
    # Convert "time_begin" and "time_end" to POSIXct using hms() from lubridate
    time_begin = hms(time_begin),
    time_end = hms(time_end),
    # Calculate "duration" as the difference between "time_end" and "time_begin"
    duration = time_end - time_begin
  )

# Modify the script to count words in "content", excluding punctuation
parsed_vtt_transformed <- parsed_vtt_transformed %>%
  mutate(
    # Remove punctuation from the content
    content_no_punctuation = str_replace_all(content, "[[:punct:]]", ""),
    # Count the number of words in the content without punctuation
    # A word is defined as a sequence of characters separated by spaces
    word_count = str_count(content_no_punctuation, "\\b\\w+\\b")
  ) %>%
  select(-content_no_punctuation)

# saving the data to Microsoft Excel and CSV formats
utils::write.csv(
  x = parsed_vtt_transformed,
  file = "parsed_vtt.csv"
)

writexl::write_xlsx(
  x = parsed_vtt_transformed,
  path = "parsed_vtt.xlsx"
)