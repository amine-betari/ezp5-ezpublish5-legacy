<?php
//
// Created on: <13-íÁÒ-2003 13:06:18 sp>
//
// SOFTWARE NAME: eZ Publish
// SOFTWARE RELEASE: 4.1.3
// BUILD VERSION: 23650
// COPYRIGHT NOTICE: Copyright (C) 1999-2009 eZ Systems AS
// SOFTWARE LICENSE: GNU General Public License v2.0
// NOTICE: >
//   This program is free software; you can redistribute it and/or
//   modify it under the terms of version 2.0  of the GNU General
//   Public License as published by the Free Software Foundation.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of version 2.0 of the GNU General
//   Public License along with this program; if not, write to the Free
//   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//   MA 02110-1301, USA.
//
//

/*! \file
*/


require_once( "kernel/common/template.php" );
$tpl = templateInit();
$tpl->setVariable( 'generated', false );
$tpl->setVariable( 'wrong_email', false );
$tpl->setVariable( 'link', false );
$tpl->setVariable( 'wrong_key', false );

$http = eZHTTPTool::instance();
$module = $Params['Module'];
$hashKey = $Params["HashKey"];
$ini = eZINI::instance();

if ( strlen( $hashKey ) == 32 )
{
    $forgotPasswdObj = eZForgotPassword::fetchByKey( $hashKey );
    if ( $forgotPasswdObj )
    {
        $user = eZUser::fetch( $forgotPasswdObj->attribute( 'user_id' ) );
        $email = $user->attribute( 'email' );

        $ini = eZINI::instance();
        $passwordLength = $ini->variable( "UserSettings", "GeneratePasswordLength" );
        $password = eZUser::createPassword( $passwordLength );
        $passwordConfirm = $password;

        $userToSendEmail = $user;
        $user->setInformation( $user->id(), $user->attribute( 'login' ), $email, $password, $passwordConfirm );

        $db = eZDB::instance();
        $db->begin();

        $user->store();

        require_once( "kernel/common/template.php" );
        $receiver = $email;
        $mail = new eZMail();
        if ( !$mail->validate( $receiver ) )
        {
        }
        $tpl = templateInit();

        $tpl->setVariable( 'user', $userToSendEmail );
        $tpl->setVariable( 'object', $userToSendEmail->attribute( 'contentobject' ) );
        $tpl->setVariable( 'password', $password );

        $templateResult = $tpl->fetch( 'design:user/forgotpasswordmail.tpl' );
        $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
        if ( !$emailSender )
            $emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
        $mail->setSender( $emailSender );
        $mail->setReceiver( $receiver );
        $subject = ezpI18n::tr( 'kernel/user/register', 'Registration info' );
        if ( $tpl->hasVariable( 'subject' ) )
            $subject = $tpl->variable( 'subject' );
        if ( $tpl->hasVariable( 'content_type' ) )
            $mail->setContentType( $tpl->variable( 'content_type' ) );
        $mail->setSubject( $subject );
        $mail->setBody( $templateResult );
        $mailResult = eZMailTransport::send( $mail );
        $tpl->setVariable( 'generated', true );
        $tpl->setVariable( 'email', $email );
        $forgotPasswdObj->remove();
        $db->commit();
    }
    else
    {
        $tpl->setVariable( 'wrong_key', true );
    }
}
else if ( strlen( $hashKey ) > 4 )
{
    $tpl->setVariable( 'wrong_key', true );
}

if ( $module->isCurrentAction( "Generate" ) )
{
    $ini = eZINI::instance();
    $passwordLength = $ini->variable( "UserSettings", "GeneratePasswordLength" );
    $password = eZUser::createPassword( $passwordLength );
    $passwordConfirm = $password;

//    $http->setSessionVariable( "GeneratedPassword", $password );

    if ( $module->hasActionParameter( "Email" ) )
    {
        $email = $module->actionParameter( "Email" );
        if ( trim( $email ) != "" )
        {
            $users = eZPersistentObject::fetchObjectList( eZUser::definition(),
                                                       null,
                                                       array( 'email' => $email ),
                                                       null,
                                                       null,
                                                       true );

			$oUsr = eZUser::fetchByEmail($email);	
            
			if($oUsr) $userSetting = eZUserSetting::fetch( $oUsr->attribute( "contentobject_id") );
			if($oUsr && $userSetting->attribute( "is_enabled" ) == 1) $isenabled = true;
			else $isenabled = false;
			
			
        }
        if ( count($users) > 0  && $isenabled)
        {
            $user = $users[0];
            $time = time();
            $hashKey = md5( $time . ":" . mt_rand() );
            $forgotPasswdObj = eZForgotPassword::createNew( $user->id(), $hashKey, $time );
            $forgotPasswdObj->store();

            $userToSendEmail = $user;
            require_once( "kernel/common/template.php" );
            $receiver = $email;

            $mail = new eZMail();
            if ( !$mail->validate( $receiver ) )
            {
            }

			include_once( "extension/convenientclasses/classes/locales/SGLocaleSwitcher.class.php" );
			$oLocaleSwitcher = new SGLocaleSwitcher();
			$oLocaleSwitcher->setUserLang($email);
			
            $tpl = templateInit();
            $tpl->setVariable( 'user', $userToSendEmail );
            $tpl->setVariable( 'object', $userToSendEmail->attribute( 'contentobject' ) );
            $tpl->setVariable( 'password', $password );
            $tpl->setVariable( 'link', true );
            $tpl->setVariable( 'hash_key', $hashKey );
            $http = eZHTTPTool::instance();
            $http->UseFullUrl = true;
            $templateResult = $tpl->fetch( 'design:user/forgotpasswordmail.tpl' );
            if ( $tpl->hasVariable( 'content_type' ) )
                $mail->setContentType( $tpl->variable( 'content_type' ) );
            $http->UseFullUrl = false;
            $emailSender = $ini->variable( 'MailSettings', 'EmailSender' );
            if ( !$emailSender )
                $emailSender = $ini->variable( 'MailSettings', 'AdminEmail' );
            $mail->setSender( $emailSender );
            $mail->setReceiver( $receiver );
            $subject = ezpI18n::tr( 'kernel/user/register', 'Registration info' );
            if ( $tpl->hasVariable( 'subject' ) )
                $subject = $tpl->variable( 'subject' );
            $mail->setSubject( $subject );
            $mail->setBody( $templateResult );
            $mailResult = eZMailTransport::send( $mail );
            $tpl->setVariable( 'email', $email );

			unset($oLocaleSwitcher);
			$module->redirectTo( '/ebyidentification/forgotpasswordemail/' );

        }
        else
        {
            $tpl->setVariable( 'wrong_email', $email );
        }
    }
}

$Result = array();
$Result['content'] = $tpl->fetch( 'design:user/forgotpassword.tpl' );
$Result['path'] = array( array( 'text' => ezpI18n::tr( 'kernel/user', 'User' ),
                                'url' => false ),
                         array( 'text' => ezpI18n::tr( 'kernel/user', 'Forgot password' ),
                                'url' => false ) );

if ( $ini->variable( 'SiteSettings', 'LoginPage' ) == 'custom' )
{
    $Result['pagelayout'] = 'loginpagelayout.tpl';
}

?>
