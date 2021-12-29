docker build -t lokcc94/multi-client:latest -t lokcc94/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lokcc94/multi-server:latest -t lokcc94/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lokcc94/multi-worker:latest -t lokcc94/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lokcc94/multi-client:latest
docker push lokcc94/multi-server:latest
docker push lokcc94/multi-worker:latest

docker push lokcc94/multi-client:$SHA
docker push lokcc94/multi-server:$SHA
docker push lokcc94/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lokcc94/multi-client:$SHA
kubectl set image deployments/server-deployment server=lokcc94/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lokcc94/multi-worker:$SHA
