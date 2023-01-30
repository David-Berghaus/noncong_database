
#Open all file names that end with .json in the current directory and add "is_congruence": false at the third line

import os

for root, dirs, files in os.walk("."):
    for file in files:
        if file.endswith(".json"):
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                lines = f.readlines()
                lines.insert(2, '    "is_congruence": false,\n')
            with open(file_path, 'w') as f:
                f.writelines(lines)
        elif file.endswith(".sage"):
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as f:
                lines = f.readlines()
                lines.insert(37, 'res["is_congruence"] = False\n')
            with open(file_path, 'w') as f:
                f.writelines(lines)

res["is_congruence"] = False
