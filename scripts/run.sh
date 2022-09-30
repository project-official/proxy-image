#! /bin/sh

if ! [ -f "ran.txt" ]; then
    echo "Modify velocity.toml..."
    #sed -i "s/{motd}/$MOTD/" velocity.toml
    #sed -i 's@{motd}@'"$MOTD"'@' velocity.toml
    #sed -i 's@{secret}@'"$VELOCITY_SECRET"'@' velocity.toml
    sed -i "s/{secret}/$VELOCITY_SECRET/" forwarding.secret
    echo "B" > ran.txt
fi

java -Xmx1G -jar velocity.jar
