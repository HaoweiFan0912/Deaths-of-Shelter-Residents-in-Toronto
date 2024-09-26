# Deaths-of-Shelter-Residents-in-Toronto

## Overview

This project utilizes the 'Deaths of Shelter Residents' dataset from OpenDataToronto (@opendatatoronto). The dataset provides monthly data on the number of shelter resident deaths in the Toronto area since 2007, along with the gender breakdown for each month. Through basic statistical and visual analysis, this project explores trends in the number of deaths over time and examines potential seasonal variations.

Note: The "Deaths of Shelter Residents" dataset can be found at: https://open.toronto.ca/dataset/deaths-of-shelter-residents/.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from https://open.toronto.ca/dataset/deaths-of-shelter-residents/.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage
This project utilized ChatGPT-4 to assist in completing part of the code and writing for the `paper.qmd` file. The main uses were as follows:
1. Consulted ChatGPT-4 on how to use the ggplot2 package and obtained code. Although the provided code wasn't fully copied, it served as a template.
2. Used ChatGPT for translation. The translations were limited to words and phrases.
3. Asked ChatGPT for guidance on using Styler for code formatting.

The full chat histories are documented in:
1. `other/llm/01-Graphing.txt`.
2. `other/llm/02-Writing.txt`.
3. `other/llm/03-Formatting.txt`.
