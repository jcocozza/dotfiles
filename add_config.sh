# Use this to add files/folders to the .configurationfiles git repo
# will create a new simlink to that location so nothing gets messed up

# Pass in the full path to the object that you want to simlink
object_to_simlink=$1
base_name=$(basename ${object_to_simlink})

script_dir=$(dirname "$(readlink -f "$0")")

new_file_location="$script_dir/files/$base_name"

# Move file to central dotfiles locations
echo "Moving $base_name to dotfiles ($new_file_location)"
mv "$object_to_simlink" "$script_dir/files"

# Create simlink
echo "Creating simlink: Mapping $new_file_location -> $object_to_simlink"
ln -s "$new_file_location" "$object_to_simlink"
