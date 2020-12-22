docker build -t deeptinair/multi-client:latest -t deeptinair/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deeptinair/multi-server:latest -t deeptinair/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deeptinair/multi-worker:latest -t deeptinair/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deeptinair/multi-client:latest
docker push deeptinair/multi-server:latest
docker push deeptinair/multi-worker:latest

docker push deeptinair/multi-client:$SHA
docker push deeptinair/multi-server:$SHA
docker push deeptinair/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=deeptinair/multi-server:$SHA
kubectl set image deployments/client-deployment client=deeptinair/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deeptinair/multi-worker:$SHA