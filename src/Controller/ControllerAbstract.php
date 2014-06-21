<?php

namespace Controller;

use Container;
use Twig_Environment;

abstract class ControllerAbstract
{
    /** @var Container */
    protected $container;
    /** @var  Twig_Environment */
    protected $twig;

    protected $disableAuthCheck = false;

    public function __construct(Container $container)
    {
        $this->container = $container;
        $this->twig      = $container->getTwig();

        if (!$this->disableAuthCheck) {
            $this->checkAuthorization();
        }
    }

    private function checkAuthorization()
    {
        $loginId = !empty($_SESSION['login_id']) ? $_SESSION['login_id'] : null;
        if (!$loginId) {
            throw new AuthorizationException();
        }
    }
}