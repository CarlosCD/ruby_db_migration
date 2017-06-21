# encoding: utf-8

server (ENV['RUN_HOST'] || 'localhost'), user: ENV['DEPLOY_USER'], roles: ['app']
