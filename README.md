
# Automated Virtual screening Workflow

## Overview

This workflow automates the molecular docking process using AutoDock Vina. It is designed to handle multiple ligand files, run docking simulations, and generate output logs and result files in an organized manner. The script processes ligand files, runs docking simulations, and logs the results, ensuring that the ligand names are correctly formatted in the logs.

## Workflow Steps

1. **Prepare Environment**
   - Install AutoDock Vina if not already installed.
   - Ensure all dependencies (e.g., Python, necessary libraries) are installed.
   - Organize the input files and directories.
2. **Preparing ligands**
   - **Converting the smiles** 
   - **Calculating discriptors**
   - **Generating 3d SDF library**
   - **Format conversion to pdbqt using openbabel**
     
2. **Define Input Parameters**
   - **Receptor File:** Path to the receptor `.pdbqt` file.
   - **Configuration File:** Path to the configuration `.txt` file for AutoDock Vina.
   - **Ligand Directory:** Directory containing all the ligand `.pdbqt` files.
   - **Output Directory:** Directory where the output results and logs will be stored.

3. **Script Execution**
   - **Run Docking:** The script iterates over each ligand file, runs the docking simulation, and stores the output in the specified directory.
   - **Log Generation:** The script generates a log file capturing the details of each docking run, ensuring that ligand names are correctly formatted without full file paths.

4. **Review Results**
   - **Output Files:** Each ligand's docking result is saved as a `.pdbqt` file in the output directory.
   - **Log Files:** A comprehensive log file (`log.txt`) is generated, documenting the docking process for each ligand.

**Notable features**
- It can iterate for each ligand in a certain file
- It also iterates for each pose and save it with the protein as a pdb complex
- It handles the log file nicely and ouputs a csv files ready to be analyzed

### Key Variables

- **ligand_file:** Path to the current ligand file being processed.
- **output_logs:** String variable accumulating all log outputs.
- **receptor:** Path to the receptor file.
- **config:** Path to the configuration file.
- **output_dir:** Directory where the result files are saved.



## Future Improvements

- **Parallel Processing:** Implement parallel processing to speed up the docking process for large datasets.
- **Visualization Tools:** Integrate tools to visualize docking results directly from the output files.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
