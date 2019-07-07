#!/bin/bash
minikube start --memory=11264 --bootstrapper=kubeadm
kubectl config use-context minikube
eval $(minikube docker-env)

certsdir="/opt/kundenportal/kp_micro_api_gateway/certificate"
minikube mount $certsdir:/opt/kundenportal/certificates/api-gateway
