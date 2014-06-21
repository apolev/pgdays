<?php

namespace Controller;

use AuthorizationException;
use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;
use Bravicility\Http\Response\RedirectResponse;
use Bravicility\Http\Response\Response;
use Container;
use Twig_Environment;

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
