<?php

namespace Controller;

use Bravicility\Http\Request;
use Bravicility\Http\Response\HtmlResponse;
use Bravicility\Http\Response\RedirectResponse;

class AuthController extends ControllerAbstract
{
    protected $disableAuthCheck = true;

    /**
     * @route GET /auth
     */
    public function getAuthForm()
    {
        return new HtmlResponse(200, $this->twig->render('login.twig', ['error_message' => '']));
    }

    /**
     * @route POST /auth
     */
    public function auth(Request $request)
    {
        $loginData = $this->container->getDb()->execute(
            'SELECT * FROM check_and_get_login(?q, ?q)',
            [$request->post('login'), $request->post('password')]
        )->fetchOneOrFalse();

        if (empty($loginData['id'])) {
            return new HtmlResponse(400, $this->twig->render(
                'login.twig',
                ['error_message' => 'Неверный логин или пароль.']
            ));
        }

        $_SESSION['login_id'] = $loginData['id'];

        return new RedirectResponse('/');
    }

    /**
     * @route GET /logout
     */
    public function logout()
    {
        $_SESSION['login_id'] = null;
        return new RedirectResponse('/auth');
    }
}
