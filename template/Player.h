#ifndef PLAYER_H
#define PLAYER_H

class Player {
public:
    static bool onTeam(void *myplayer, void *otherPlayer);
    static bool isAlive(void *Player);
    static bool isMine(void *Player);
};

typedef int (*onTeamCall)(void *, void *);
typedef bool (*isAliveCall)(void *, bool);

bool Player::onTeam(void *myPlayer, void *otherPlayer) {
    static onTeamCall func = (onTeamCall)getRealOffset(offset::player::playerOnTeam);
    return func(myPlayer, otherPlayer);
}

bool Player::isAlive(void *Player) {
    static isAliveCall func = (isAliveCall)getRealOffset(offset::player::playerAlive);
    return func(Player, true);
}

bool Player::isMine(void *Player) {
    return *(bool *)((uint64_t)Player + offset::player::isMine);
}

#endif