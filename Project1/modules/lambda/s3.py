import boto3

def lambda_handler(event, context):
    s3 = boto3.resource('s3', region_name=event["name"])
    bucket = s3.Bucket('bucket_name_qpwoei')

    if bucket.creation_date:
        print("A bucket exists")
    else:
        print("A bucket will be created")
        bucket.create()
