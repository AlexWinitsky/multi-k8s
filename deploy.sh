docker build -t alexwinicky/multi-client:latest -t alexwinicky/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexwinicky/multi-server:latest -t alexwinicky/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexwinicky/multi-worker:latest -t alexwinicky/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexwinicky/multi-client:latest
docker push alexwinicky/multi-server:latest
docker push alexwinicky/multi-worker:latest

docker push alexwinicky/multi-client:$SHA
docker push alexwinicky/multi-server:$SHA
docker push alexwinicky/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexwinicky/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexwinicky/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexwinicky/multi-worker:$SHA