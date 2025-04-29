#!/bin/bash
# Function to run docking for a single ligand
cd /content/library/optimized/pdbqt
run_docking() {
    ligand_file="$1"
    receptor="$2"
    config="$3"
    output_dir="$4"
    log_file="$5"

    # Extract the ligand name without the full path and extension
    ligand_name=$(basename "${ligand_file}")
    ligand_base_name="${ligand_name%.*}"
    output_file="${output_dir}/${ligand_base_name}_results.pdbqt"

    echo "Running ${ligand_name}"

    # Start logging
    echo -e "\n[STARTRUN] $(date) LIGAND ${ligand_name}" >> "${log_file}"
    echo "[STARTLOG]" >> "${log_file}"

    # Run AutoDock Vina
    vina_1.2.5_linux_x86_64 --config "${config}" --ligand "${ligand_file}" --receptor "${receptor}" --out "${output_file}" \
        >> "${log_file}" 2>&1

    if [ $? -eq 0 ]; then
        echo "Docking completed for ${ligand_name}"
    else
        echo "Error occurred during docking for ${ligand_name}"
    fi

    # End logging
    echo "[ENDLOG]" >> "${log_file}"
    echo "[ENDRUN] $(date)" >> "${log_file}"
    echo "++++++++++" >> "${log_file}"
    echo "++++++++++"
}

# Parse command-line arguments
while getopts "r:c:L:o:" opt; do
    case ${opt} in
        r) receptor="${OPTARG}" ;;
        c) config="${OPTARG}" ;;
        L) ligand_dir="${OPTARG}" ;;
        o) output_dir="${OPTARG}" ;;
        *) echo "Invalid option"; exit 1 ;;
    esac
done

# Ensure required arguments are provided
if [ -z "${receptor}" ] || [ -z "${config}" ] || [ -z "${ligand_dir}" ] || [ -z "${output_dir}" ]; then
    echo "Usage: $0 -r <receptor> -c <config> -L <ligand directory> -o <output directory>"
    exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "${output_dir}"

# Log file
log_file="${output_dir}/log.txt"
> "${log_file}"  # Clear previous logs

# Process each ligand file in the ligand directory
for ligand_file in "${ligand_dir}"/*.pdbqt; do
    if [ -f "${ligand_file}" ]; then
        run_docking "${ligand_file}" "${receptor}" "${config}" "${output_dir}" "${log_file}"
    else
        echo "No .pdbqt files found in ${ligand_dir}"
    fi
done

echo "Docking complete. Logs saved to ${log_file}."
