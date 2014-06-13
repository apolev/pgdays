<?php

namespace Controller;

use Bravicility\Http\Response\HtmlResponse;

class IndexController
{
    /**
     * @route GET /
     */
    public function index()
    {
        $html = file_get_contents(__DIR__ . '/../templates/layout.tpl');
        return new HtmlResponse(200, $html);
    }
}