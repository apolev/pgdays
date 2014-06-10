<?php

use Bravicility\Container\DbContainerTrait;

class Container
{
    use DbContainerTrait;

    private $config = array();

    public function __construct()
    {
        $this->config = parse_ini_file(__DIR__ . '/../config/parameters.ini');
        $this->loadDbConfig($this->config);
    }

    protected function ensureParameters(array $config, array $parameterNames)
    {
        $undefinedMessages = array();
        foreach ($parameterNames as $name) {
            if (!isset($config[$name])) {
                $undefinedMessages[] = "Config parameter {$name} is not defined";
            }
        }

        if (count($undefinedMessages) > 0) {
            throw new \LogicException(implode("\n", $undefinedMessages));
        }
    }
}