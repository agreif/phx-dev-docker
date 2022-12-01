echo "###### build docker image ############"
docker image build -t agreif/phx-dev .

echo "###### push docker image ############"
docker push agreif/phx-dev

echo "###### remove local docker image ############"
docker image rm agreif/phx-dev
