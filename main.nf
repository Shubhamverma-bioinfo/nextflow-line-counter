#!/usr/bin/env nextflow

nextflow.enable.dsl=2

process countLinesProcess {
  publishDir "${params.outdir}/", mode: 'copy'
  input:
    path file_path

  output:
    path 'output.txt'

  script:
    """
    # Count the number of lines in the file and store the result in output.txt
    wc -l "$file_path" > output.txt
    """
}

workflow {
  // Use the provided file_path parameter or specify a default file path
  file_path = params.file_path ?: 'path/to/your/file.txt'

  // Create a Channel with the file path
  pathChannel = Channel.fromPath(file_path)

  // Run the countLines process on the file path
  pathChannel | countLinesProcess
}

