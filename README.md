# webVTT files data parsing
The Web Video Text Tracks format ([WebVTT]([url](https://www.w3.org/TR/webvtt1/))) text files "provide captions or subtitles for video content, and also text video descriptions, chapters for content navigation, and more generally any form of metadata that is time-aligned with audio or video content"[^1]. This format is widely used on platforms such as YouTube for subtitles or captions [^2] or Microsoft Teams meetings [^3]. WebVTT data can be useful in a wide range of situations, e.g. for researchers and analysts working with qualitative data. The purpose of this script is to transform any webVTT fill to be easily analyzed using data analysis tools.

## Description
This R script provides a convenient and efficient way to convert WebVTT (.VTT) files into a tidy tibble format. The script processes the webVTT file, diarizing the content for each speaker, and consolidating spoken content. It calculates the duration of each speaking turn, counts the number of words, and exports the data to both Microsoft Excel (.XLSX) and CSV formats (.CSV).

[^1]: World Wide Web Consortium (W3C). (n.d.). WebVTT: The Web Video Text Tracks Format. Retrieved November 14, 2023, from ([WebVTT]([url](https://www.w3.org/TR/webvtt1/)))
[^2]: YouTube Help. (n.d.). Supported subtitle and closed caption files. Retrieved November 14, 2023, from https://support.google.com/youtube/answer/2734698?hl=en
[^3]: Microsoft Support. (n.d.). View live transcription in Microsoft Teams meetings. Retrieved November 14, 2023, from https://support.microsoft.com/en-us/office/view-live-transcription-in-microsoft-teams-meetings-dc1a8f23-2e20-4684-885e-2152e06a4a8b#bkmk_download

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
