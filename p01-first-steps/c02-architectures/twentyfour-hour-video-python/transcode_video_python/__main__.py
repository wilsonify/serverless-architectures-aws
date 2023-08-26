import json
import os
import urllib.parse

import boto3


def lambda_handler(event, context):
    try:
        bucket_name = get_bucket_from_s3_put(event)
        source_key = get_key_from_s3_put(event)
        input_uri = f's3://{bucket_name}/{source_key}'
        output_bucket_name = os.environ['TRANSCODED_VIDEO_BUCKET']
        output_prefix = source_key.split('.')[0]
        output_uri = f's3://{output_bucket_name}/{output_prefix}/'
        job = {
            'Role': os.environ['MEDIA_ROLE'],
            'Settings': {
                'Inputs': [{
                    'FileInput': input_uri,
                    'AudioSelectors': {
                        'Audio Selector 1': {
                            'SelectorType': 'TRACK',
                            'Tracks': [1]
                        }
                    }
                }],
                'OutputGroups': [{
                    'Name': 'File Group',
                    'Outputs': [{
                        'Preset': 'System-Generic_Hd_Mp4_Avc_Aac_16x9_1920x1080p_24Hz_6Mbps',
                        'Extension': 'mp4',
                        'NameModifier': '_16x9_1920x1080p_24Hz_6Mbps'
                    }, {
                        'Preset': 'System-Generic_Hd_Mp4_Avc_Aac_16x9_1280x720p_24Hz_4.5Mbps',
                        'Extension': 'mp4',
                        'NameModifier': '_16x9_1280x720p_24Hz_4.5Mbps'
                    }, {
                        'Preset': 'System-Generic_Sd_Mp4_Avc_Aac_4x3_640x480p_24Hz_1.5Mbps',
                        'Extension': 'mp4',
                        'NameModifier': '_4x3_640x480p_24Hz_1.5Mbps'
                    }],
                    'OutputGroupSettings': {
                        'Type': 'FILE_GROUP_SETTINGS',
                        'FileGroupSettings': {
                            'Destination': output_uri
                        }
                    }
                }]
            }
        }
        media_convert = boto3.client('mediaconvert', endpoint_url=os.environ['MEDIA_ENDPOINT'])
        media_convert_result = media_convert.create_job(**job)
        print(media_convert_result)

    except Exception as e:
        print(f"e={e}")

    return {
        'statusCode': 200,
        'body': json.dumps('Video transcoding job submitted successfully!')
    }


def get_key_from_s3_put(event):
    key = event['Records'][0]['s3']['object']['key']
    source_key = urllib.parse.unquote(key.replace('+', ' '))
    return source_key


def get_bucket_from_s3_put(event):
    bucket_name = event["Records"][0]["s3"]["bucket"]["name"]
    return bucket_name
