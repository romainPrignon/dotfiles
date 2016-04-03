<?php
namespace Hirak\Prestissimo\Aspects;

use Composer\IO;

class AspectAuthTest extends \PHPUnit_Framework_TestCase
{
    /**
     * @expectedException Composer\Downloader\TransportException
     */
    public function testUpdateOnError()
    {
        $req = new HttpGetRequest('example.com', 'https://example.com/', new IO\NullIO);
        $postDownload = new JoinPoint('post-download', $req);

        $res = new HttpGetResponse(123456, '', array(
            'http_code' => 200,
        ));
        $postDownload->setResponse($res);
        $auth = new AspectAuth;
        $auth->update($postDownload);
    }

    public function testUpdateOnPostDownload()
    {
        $req = new HttpGetRequest('example.com', 'https://example.com/', new IO\NullIO);
        $postDownload = new JoinPoint('post-download', $req);

        $res = new HttpGetResponse(CURLE_OK, '', array(
            'http_code' => 200,
        ));
        $postDownload->setResponse($res);
        $auth = new AspectAuth;
        $auth->update($postDownload);
        self::assertFalse($res->needAuth(), 'status 200 is ok');

        $res = new HttpGetResponse(CURLE_OK, '', array(
            'http_code' => 401,
        ));
        $postDownload->setResponse($res);
        $auth->update($postDownload);
        self::assertTrue($res->needAuth(), 'status 401 need auth');

        $res = new HttpGetResponse(CURLE_OK, '', array(
            'http_code' => 403,
        ));
        $postDownload->setResponse($res);
        $auth->update($postDownload);
        self::assertTrue($res->needAuth(), 'status 403 need auth');

        $res = new HttpGetResponse(CURLE_OK, '', array(
            'http_code' => 404,
        ));
        $postDownload->setResponse($res);
        $auth->update($postDownload);
        self::assertTrue($res->needAuth(), 'status 404 need auth');

        $res = new HttpGetResponse(CURLE_OK, '', array(
            'http_code' => 407,
        ));
        $postDownload->setResponse($res);
        $auth->update($postDownload);
        self::assertFalse($res->needAuth(), 'status 407 don\'t need auth');
    }
}
