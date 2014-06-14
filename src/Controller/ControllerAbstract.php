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

    public function __construct(Container $container)
    {
        $this->container = $container;
        $this->twig      = $container->getTwig();
    }
}