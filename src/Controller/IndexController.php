<?php

namespace Controller;

use Bravicility\Http\Response\HtmlResponse;


class IndexController extends ControllerAbstract
{
    /**
     * @route GET /
     */
    public function index()
    {
        return new HtmlResponse(200, $this->twig->render('index.twig'));
    }
}
