alias aws-get-p2='export instanceId=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped,Name=instance-type,Values=p2.xlarge" --query "Reservations[0].Instances[0].InstanceId"` && echo $instanceId'
alias aws-get-t2-micro='export instanceId=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped,Name=instance-type,Values=t2.micro" --query "Reservations[0].Instances[0].InstanceId"` && echo $instanceId'
alias aws-get-t2-xlarge='export instanceId=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped,Name=instance-type,Values=t2.xlarge" --query "Reservations[0].Instances[0].InstanceId"` && echo $instanceId'
alias aws-start='aws ec2 start-instances --instance-ids $instanceId && aws ec2 wait instance-running --instance-ids $instanceId && export instanceIp=`aws ec2 describe-instances --filters "Name=instance-id,Values=$instanceId" --query "Reservations[0].Instances[0].PublicIpAddress"` && echo $instanceIp'
alias aws-ip='export instanceIp=`aws ec2 describe-instances --filters "Name=instance-id,Values=$instanceId" --query "Reservations[0].Instances[0].PublicIpAddress"` && echo $instanceIp'
alias aws-ssh-t2-micro='aws-get-t2-micro && export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].PublicDnsName" --output text) && ssh -i /home/james/.ssh/aws-key-fast-ai.pem ubuntu@$instanceUrl'
alias aws-ssh-t2-xlarge='aws-get-t2-xlarge && export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].PublicDnsName" --output text) && ssh -i /home/james/.ssh/aws-key-fast-ai.pem ubuntu@$instanceUrl'
alias aws-ssh-p2='aws-get-p2 && export instanceUrl=$(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].PublicDnsName" --output text) && ssh -i /home/james/.ssh/aws-key-fast-ai.pem ubuntu@$instanceUrl'
alias aws-stop='aws ec2 stop-instances --instance-ids $instanceId'
alias aws-state='aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].State.Name"'
alias aws-micro-to-xlarge='aws-get-t2-micro && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type t2.xlarge && aws-start'
alias aws-micro-to-p2='aws-get-t2-micro && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type p2.xlarge && aws-start'
alias aws-xlarge-to-micro='aws-get-t2-xlarge && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type t2.micro && aws-start'
alias aws-xlarge-to-p2='aws-get-t2-xlarge && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type p2.xlarge && aws-start'
alias aws-p2-to-micro='aws-get-p2 && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type t2.micro && aws-start'
alias aws-p2-to-xlarge='aws-get-p2 && aws-stop && sleep 30 && aws ec2 modify-instance-attribute --instance-id $instanceId --instance-type t2.xlarge && aws-start'

if [[ `uname` == *"CYGWIN"* ]]
then
    # This is cygwin.  Use cygstart to open the notebook
    alias aws-nb='cygstart http://$instanceIp:8888'
fi

if [[ `uname` == *"Linux"* ]]
then
    # This is linux.  Use xdg-open to open the notebook
    alias aws-nb='xdg-open https://$instanceIp:8888'
fi

if [[ `uname` == *"Darwin"* ]]
then
    # This is Mac.  Use open to open the notebook
    alias aws-nb='open http://$instanceIp:8888'
fi
