<?php

namespace Controller;

use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;

class AuthController extends ControllerAbstract
{

    /**
     * @route GET /auth
     */
    public function getAuthForm()
    {
        return new HtmlResponse(200, $this->twig->render('login.twig'));
    }

    /**
     * @route POST /auth
     */
    public function auth(Request $request)
    {
        $loginData = $this->container->getDb()->execute(
            'SELECT * FROM check_and_get_login(?q, ?q)',
            array($request->post('login'), $request->post('password'))
        )->fetchOneOrFalse();

        var_dump($loginData);
        die();
        if (!$loginData) {
            return new HtmlResponse(400, $this->twig->render(
                'login.twig',
                array('error_message' => 'Неверный логин или пароль.')
            ));
        }

        $_SESSION['login_id'] = $loginData['id'];

        return new RedirectResponse('/');
    }
}