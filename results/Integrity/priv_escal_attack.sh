rm #!/bin/bash

echo "--------------------------------------------------------------------------"
echo "Gaining root privileges"
./gain_root_priv

echo "--------------------------------------------------------------------------"
echo "Restart User Session to apply changes"
id 
su -l user1
id