/**
 * Created by Peter Sbarski
 * Serverless Architectures on AWS
 * http://book.acloud.guru/
 * Last Updated: Feb 11, 2017
 */

'use strict';
const AWS = require('aws-sdk');
const mediaConvert = new AWS.MediaConvert({ endpoint: process.env.MEDIA_ENDPOINT });
const outputBucketName = process.env.TRANSCODED_VIDEO_BUCKET

exports.handler = async (event, context) => {
    console.log('Welcome');
    const key = event.Records[0].s3.object.key;
    var sourceKey = decodeURIComponent(key.replace(/\+/g, ' ')); //the input file may have '+' so replace them with spaces
    var outputKey = sourceKey.split('.')[0]; //remove the extension
    var params = {
        PipelineId: '1451470066051-jscnci',
        Input: {
            Key: sourceKey
        },
        Outputs: [
            {
                Key: outputKey + '-1080p' + '.mp4',
                PresetId: '1351620000001-000001' //Generic 1080p
            },
            {
                Key: outputKey + '-720p' + '.mp4',
                PresetId: '1351620000001-000010' //Generic 720p
            },
            {
                Key: outputKey + '-web-720p' + '.mp4',
                PresetId: '1351620000001-100070' //Web Friendly 720p
            }
        ]};

    elasticTranscoder.createJob(params, function(error, data){
        if (error){
            callback(error);
        }
    });
};
