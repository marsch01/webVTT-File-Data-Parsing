# webVTT *.VTT files data parsing

## Description
This R script provides a convenient and efficient way to convert WebVTT (.VTT) files into a tidy tibble format. It is especially useful for researchers and analysts working with qualitative data. The script processes .VTT files, diarizing the content for each speaker, and consolidating spoken content. It calculates the duration of each speaking turn, counts the number of words, and exports the data into both Microsoft Excel and CSV formats.

## Features
- **Diarization**: Consolidates content for each speaker, grouping consecutive segments spoken by the same individual.
- **Duration Calculation**: Computes the speaking duration for each diarized segment.
- **Word Count**: Counts the number of words in each spoken segment.
- **Data Export**: Saves the processed data in both Microsoft Excel and CSV formats for easy use in further analysis.

## Installation
No special installation is required apart from having R installed on your system. However, ensure that all necessary R packages mentioned in the script are installed.

## Usage
To use the script, simply replace the `file_path` variable with the file path of the .VTT file you wish to convert. For example:

```r
file_path <- "path/to/your/file.vtt"
