#!/bin/bash

cluster_info=`aws emr create-cluster \
  --auto-scaling-role EMR_AutoScaling_DefaultRole \
  --termination-protected 
  --applications Name=Hadoop Name=Hive Name=Pig Name=Hue \
  --ebs-root-volume-size 10 \
  --ec2-attributes '{"InstanceProfile":"EMR_EC2_DefaultRole","SubnetId":"subnet-24dc947d","EmrManagedSlaveSecurityGroup":"sg-c8c50fae","EmrManagedMasterSecurityGroup":"sg-dcc309ba"}' \
  --service-role EMR_DefaultRole \
  --enable-debugging \
  --release-label emr-5.11.0 \
  --log-uri 's3n://aws-logs-816961105770-ap-northeast-1/elasticmapreduce/' \
  --name 'My cluster' \
  --instance-groups '[{"InstanceCount":1,"InstanceGroupType":"CORE","InstanceType":"m3.xlarge","Name":"Core - 2"},{"InstanceCount":1,"InstanceGroupType":"MASTER","InstanceType":"m3.xlarge","Name":"Master - 1"}]' \
  --scale-down-behavior TERMINATE_AT_TASK_COMPLETION \
  --region ap-northeast-1`
echo $cluster_info
