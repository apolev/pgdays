<?php

use Bravicility\Container\DbContainerTrait;
use Bravicility\Container\LoggingContainerTrait;
use Bravicility\Container\RouterContainerTrait;
use Bravicility\Container\TwigContainerTrait;

class Container
{
    use DbContainerTrait;
    use LoggingContainerTrait;
    use RouterContainerTrait;
    use TwigContainerTrait;

    private $config = [];

    public function __construct()
    {
        $this->config = parse_ini_file(__DIR__ . '/../config/parameters.ini');
        $this->loadDbConfig($this->config);
        $this->loadRouterConfig($this->config, $this->getRootDirectory());
        $this->loadLoggingConfig($this->config, $this->getRootDirectory());
        $this->loadTwigConfig($this->config, $this->getRootDirectory());
    }

    public function getRootDirectory()
    {
        return __DIR__ . '/..';
    }

    protected function ensureParameters(array $config, array $parameterNames)
    {
        $undefinedMessages = [];
        foreach ($parameterNames as $name) {
            if (!isset($config[$name])) {
                $undefinedMessages[] = "Config parameter {$name} is not defined";
            }
        }

        if (count($undefinedMessages) > 0) {
            throw new \LogicException(implode("\n", $undefinedMessages));
        }
    }

    public function getHost()
    {

    }
}