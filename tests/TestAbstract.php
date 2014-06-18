<?php

use Grace\DBAL\ConnectionAbstract\ConnectionInterface;

class TestAbstract extends \PHPUnit_Framework_TestCase
{
    use TestBrowserTrait;

    /** @var Container */
    protected $container;

    /** @var  ConnectionInterface */
    protected $db;

    protected function setUp()
    {
        $this->container = new Container();
        $this->db        = $this->container->getDb();
        $this->prepareHttpClient('http://' . $this->container->getHost());
    }
}
