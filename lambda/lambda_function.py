import boto3
import os



def lambda_handler(event, context):

    ec2 = boto3.client('ec2', region_name='eu-west-2')

    #instance_ids = ['i-0d21c7d3711410191']
    
    instance_ids = os.environ['DR_INSTANCE_ID']

    try:
        response = ec2.start_instances(InstanceIds=[instance_ids])

        print("Start response:", response)

        return {
            "statusCode": 200,
            "body": "EC2 start command sent successfully"
        }

    except Exception as e:
        print("Error:", str(e))

        return {
            "statusCode": 500,
            "body": str(e)
        }