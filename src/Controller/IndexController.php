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
    public function __construct(Container $container)
    {
        parent::__construct($container);
        $this->checkAuthorization();
    }

    private function checkAuthorization()
    {
        $loginId = !empty($_SESSION['login_id']) ? $_SESSION['login_id'] : null;
        if (!$loginId) {
            throw new AuthorizationException();
        }
    }

    /**
     * @route GET /
     */
    public function index()
    {
        return new HtmlResponse(200, $this->twig->render('index.twig'));
    }
}
