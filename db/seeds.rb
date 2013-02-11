# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AtaxxBoard.destroy_all
AtaxxBoard.create(name: 'Standard', x_size: 7, y_size: 7)

GameCode.destroy_all
GameCode.create(name: 'ataxx')

Game.destroy_all
Game.create(name: 'Ataxx', game_code_id: GameCode.find_by_name('ataxx').id)

AtaxxVersion.destroy_all
AtaxxVersion.create(name: '1.0.0', code: 10000, game_id: Game.find_by_name('Ataxx').id)

# AtaxxSession.destroy_all
User.destroy_all
User.create(username: 'mullet', first_name: 'Mr.', last_name: 'Sprinkles')
User.create(username: 'ender', first_name: 'Mr.', last_name: 'Fluffy')
