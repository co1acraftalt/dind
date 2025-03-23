docker compose --file /workspaces/$(basename $PWD)/windows/windows.yaml down
rm --force /workspaces/$(basename $PWD)/windows/data.img
docker compose --file /workspaces/$(basename $PWD)/windows/windows.yaml up
