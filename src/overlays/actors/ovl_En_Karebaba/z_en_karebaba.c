/**
 * File: z_en_karebaba.c
 * Overlay: ovl_En_Karebaba
 * Description: Withered Deku Baba
 */

#include "z_en_karebaba.h"
#include "overlays/effects/ovl_Effect_Ss_Hahen/z_eff_ss_hahen.h"

#define FLAGS 0x00000005

#define THIS ((EnKarebaba*)thisx)

void EnKarebaba_Init(Actor* thisx, GlobalContext* globalCtx);
void EnKarebaba_Destroy(Actor* thisx, GlobalContext* globalCtx);
void EnKarebaba_Update(Actor* thisx, GlobalContext* globalCtx);
void EnKarebaba_Draw(Actor* thisx, GlobalContext* globalCtx);

void EnKarebaba_SetupGrow(EnKarebaba* this);
void EnKarebaba_SetupIdle(EnKarebaba* this);
void EnKarebaba_Grow(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Idle(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Awaken(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Spin(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Dying(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_DeadItemDrop(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Retract(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Dead(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Regrow(EnKarebaba* this, GlobalContext* globalCtx);
void EnKarebaba_Upright(EnKarebaba* this, GlobalContext* globalCtx);

const ActorInit En_Karebaba_InitVars = {
    ACTOR_EN_KAREBABA,
    ACTORTYPE_ENEMY,
    FLAGS,
    OBJECT_DEKUBABA,
    sizeof(EnKarebaba),
    (ActorFunc)EnKarebaba_Init,
    (ActorFunc)EnKarebaba_Destroy,
    (ActorFunc)EnKarebaba_Update,
    (ActorFunc)EnKarebaba_Draw,
};

static ColliderCylinderInit sBodyColliderInit = {
    { 0xC, 0, 9, 0, 0x10, COLSHAPE_CYLINDER },
    { 0, { 0x00000000, 0, 0 }, { ~0x00300000, 0, 0 }, 0, 1, 0 },
    { 7, 25, 0, { 0, 0, 0 } },
};

static ColliderCylinderInit sHeadColliderInit = {
    { 0x0C, 0x11, 0, 0x39, 0x10, COLSHAPE_CYLINDER },
    { 0, { ~0x00300000, 0, 8 }, { 0x00000000, 0, 0 }, 9, 0, 1 },
    { 4, 25, 0, { 0, 0, 0 } },
};

static CollisionCheckInfoInit sColCheckInfoInit = { 1, 15, 80, 0xFE };

static InitChainEntry sInitChain[] = {
    ICHAIN_F32(unk_4C, 2500, ICHAIN_CONTINUE),
    ICHAIN_U8(unk_1F, 1, ICHAIN_CONTINUE),
    ICHAIN_S8(naviEnemyId, 9, ICHAIN_STOP),
};

extern SkeletonHeader D_06002A40;
extern AnimationHeader D_060002B8;
extern Gfx D_06003070[]; // deku stick drop
extern Gfx D_060010F0[]; // leaf base
extern Gfx D_06001828[]; // upper third of stem
extern Gfx D_06001330[]; // mid third of stem
extern Gfx D_06001628[]; // lower third of stem

void EnKarebaba_Init(Actor* thisx, GlobalContext* globalCtx) {
    EnKarebaba* this = THIS;

    Actor_ProcessInitChain(&this->actor, sInitChain);
    ActorShape_Init(&this->actor.shape, 0.0f, ActorShadow_DrawFunc_Circle, 22.0f);
    SkelAnime_Init(globalCtx, &this->skelAnime, &D_06002A40, &D_060002B8, this->jointTable, this->morphTable, 8);
    Collider_InitCylinder(globalCtx, &this->bodyCollider);
    Collider_SetCylinder(globalCtx, &this->bodyCollider, &this->actor, &sBodyColliderInit);
    Collider_CylinderUpdate(&this->actor, &this->bodyCollider);
    Collider_InitCylinder(globalCtx, &this->headCollider);
    Collider_SetCylinder(globalCtx, &this->headCollider, &this->actor, &sHeadColliderInit);
    Collider_CylinderUpdate(&this->actor, &this->headCollider);
    func_80061ED4(&this->actor.colChkInfo, DamageTable_Get(1), &sColCheckInfoInit);

    this->boundFloor = NULL;

    if (this->actor.params == 0) {
        EnKarebaba_SetupGrow(this);
    } else {
        EnKarebaba_SetupIdle(this);
    }
}

void EnKarebaba_Destroy(Actor* thisx, GlobalContext* globalCtx) {
    EnKarebaba* this = THIS;

    Collider_DestroyCylinder(globalCtx, &this->bodyCollider);
    Collider_DestroyCylinder(globalCtx, &this->headCollider);
}

void EnKarebaba_ResetCollider(EnKarebaba* this) {
    this->bodyCollider.dim.radius = 7;
    this->bodyCollider.dim.height = 25;
    this->bodyCollider.base.type = COLTYPE_UNK12;
    this->bodyCollider.base.acFlags |= 4;
    this->bodyCollider.body.bumper.flags = ~0x00300000;
    this->headCollider.dim.height = 25;
}

void EnKarebaba_SetupGrow(EnKarebaba* this) {
    Actor_SetScale(&this->actor, 0.0f);
    this->actor.shape.rot.x = -0x4000;
    this->actionFunc = EnKarebaba_Grow;
    this->actor.posRot.pos.y = this->actor.initPosRot.pos.y + 14.0f;
}

void EnKarebaba_SetupIdle(EnKarebaba* this) {
    Actor_SetScale(&this->actor, 0.005f);
    this->actor.shape.rot.x = -0x4000;
    this->actionFunc = EnKarebaba_Idle;
    this->actor.posRot.pos.y = this->actor.initPosRot.pos.y + 14.0f;
}

void EnKarebaba_SetupAwaken(EnKarebaba* this) {
    Animation_Change(&this->skelAnime, &D_060002B8, 4.0f, 0.0f, Animation_GetLastFrame(&D_060002B8), 0, -3.0f);
    Audio_PlayActorSound2(&this->actor, NA_SE_EN_DUMMY482);
    this->actionFunc = EnKarebaba_Awaken;
}

void EnKarebaba_SetupUpright(EnKarebaba* this) {
    if (this->actionFunc != EnKarebaba_Spin) {
        Actor_SetScale(&this->actor, 0.01f);
        this->bodyCollider.base.type = COLTYPE_UNK6;
        this->bodyCollider.base.acFlags &= ~0x0004;
        this->bodyCollider.body.bumper.flags = gSaveContext.linkAge != 0 ? 0x07C00710 : 0x0FC00710;
        this->bodyCollider.dim.radius = 15;
        this->bodyCollider.dim.height = 80;
        this->headCollider.dim.height = 80;
    }

    this->actor.params = 40;
    this->actionFunc = EnKarebaba_Upright;
}

void EnKarebaba_SetupSpin(EnKarebaba* this) {
    this->actor.params = 40;
    this->actionFunc = EnKarebaba_Spin;
}

void EnKarebaba_SetupDying(EnKarebaba* this) {
    this->actor.params = 0;
    this->actor.gravity = -0.8f;
    this->actor.velocity.y = 4.0f;
    this->actor.posRot.rot.y = this->actor.shape.rot.y + 0x8000;
    this->actor.speedXZ = 3.0f;
    Audio_PlayActorSound2(&this->actor, NA_SE_EN_DEKU_JR_DEAD);
    this->actor.flags |= 0x30;
    this->actionFunc = EnKarebaba_Dying;
}

void EnKarebaba_SetupDeadItemDrop(EnKarebaba* this, GlobalContext* globalCtx) {
    Actor_SetScale(&this->actor, 0.03f);
    this->actor.shape.rot.x -= 0x4000;
    this->actor.shape.unk_08 = 1000.0f;
    this->actor.gravity = 0.0f;
    this->actor.velocity.y = 0.0f;
    this->actor.shape.unk_10 = 3.0f;
    Actor_ChangeType(globalCtx, &globalCtx->actorCtx, &this->actor, ACTORTYPE_MISC);
    this->actor.params = 200;
    this->actor.flags &= ~0x20;
    this->actionFunc = EnKarebaba_DeadItemDrop;
}

void EnKarebaba_SetupRetract(EnKarebaba* this) {
    Animation_Change(&this->skelAnime, &D_060002B8, -3.0f, Animation_GetLastFrame(&D_060002B8), 0.0f, 2, -3.0f);
    EnKarebaba_ResetCollider(this);
    this->actionFunc = EnKarebaba_Retract;
}

void EnKarebaba_SetupDead(EnKarebaba* this) {
    Animation_Change(&this->skelAnime, &D_060002B8, 0.0f, 0.0f, 0.0f, 2, 0.0f);
    EnKarebaba_ResetCollider(this);
    this->actor.shape.rot.x = -0x4000;
    this->actor.params = 200;
    this->actor.parent = NULL;
    this->actor.shape.unk_10 = 0.0f;
    Math_Vec3f_Copy(&this->actor.posRot.pos, &this->actor.initPosRot.pos);
    this->actionFunc = EnKarebaba_Dead;
}

void EnKarebaba_SetupRegrow(EnKarebaba* this) {
    this->actor.shape.unk_08 = 0.0f;
    this->actor.shape.unk_10 = 22.0f;
    this->headCollider.dim.radius = sHeadColliderInit.dim.radius;
    Actor_SetScale(&this->actor, 0.0f);
    this->actionFunc = EnKarebaba_Regrow;
}

void EnKarebaba_Grow(EnKarebaba* this, GlobalContext* globalCtx) {
    f32 scale;

    this->actor.params++;
    scale = this->actor.params * 0.05f;
    Actor_SetScale(&this->actor, 0.005f * scale);
    this->actor.posRot.pos.y = this->actor.initPosRot.pos.y + (14.0f * scale);
    if (this->actor.params == 20) {
        EnKarebaba_SetupIdle(this);
    }
}

void EnKarebaba_Idle(EnKarebaba* this, GlobalContext* globalCtx) {
    if (this->actor.xzDistFromLink < 200.0f && fabsf(this->actor.yDistFromLink) < 30.0f) {
        EnKarebaba_SetupAwaken(this);
    }
}

void EnKarebaba_Awaken(EnKarebaba* this, GlobalContext* globalCtx) {
    SkelAnime_Update(&this->skelAnime);
    Math_StepToF(&this->actor.scale.x, 0.01f, 0.0005f);
    this->actor.scale.y = this->actor.scale.z = this->actor.scale.x;
    if (Math_StepToF(&this->actor.posRot.pos.y, this->actor.initPosRot.pos.y + 60.0f, 5.0f)) {
        EnKarebaba_SetupUpright(this);
    }
    this->actor.shape.rot.y += 0x1999;
    EffectSsHahen_SpawnBurst(globalCtx, &this->actor.initPosRot.pos, 3.0f, 0, 12, 5, 1, HAHEN_OBJECT_DEFAULT, 10, NULL);
}

void EnKarebaba_Upright(EnKarebaba* this, GlobalContext* globalCtx) {
    Player* player = PLAYER;

    SkelAnime_Update(&this->skelAnime);

    if (this->actor.params != 0) {
        this->actor.params--;
    }

    if (Animation_OnFrame(&this->skelAnime, 0.0f) || Animation_OnFrame(&this->skelAnime, 12.0f)) {
        Audio_PlayActorSound2(&this->actor, NA_SE_EN_DEKU_JR_MOUTH);
    }

    if (this->bodyCollider.base.acFlags & 2) {
        EnKarebaba_SetupDying(this);
        func_80032C7C(globalCtx, &this->actor);
    } else if (Math_Vec3f_DistXZ(&this->actor.initPosRot.pos, &player->actor.posRot.pos) > 240.0f) {
        EnKarebaba_SetupRetract(this);
    } else if (this->actor.params == 0) {
        EnKarebaba_SetupSpin(this);
    }
}

void EnKarebaba_Spin(EnKarebaba* this, GlobalContext* globalCtx) {
    s32 value;
    f32 cos60;

    if (this->actor.params != 0) {
        this->actor.params--;
    }

    SkelAnime_Update(&this->skelAnime);

    if (Animation_OnFrame(&this->skelAnime, 0.0f) || Animation_OnFrame(&this->skelAnime, 12.0f)) {
        if (1) {} // Here for matching purposes only.

        Audio_PlayActorSound2(&this->actor, NA_SE_EN_DEKU_JR_MOUTH);
    }

    value = 20 - this->actor.params;
    value = 20 - ABS(value);

    if (value > 10) {
        value = 10;
    }

    this->headCollider.dim.radius = sHeadColliderInit.dim.radius + (value * 2);
    this->actor.shape.rot.x = 0xC000 - (value * 0x100);
    this->actor.shape.rot.y += value * 0x2C0;
    this->actor.posRot.pos.y = (Math_SinS(this->actor.shape.rot.x) * -60.0f) + this->actor.initPosRot.pos.y;

    cos60 = Math_CosS(this->actor.shape.rot.x) * 60.0f;

    this->actor.posRot.pos.x = (Math_SinS(this->actor.shape.rot.y) * cos60) + this->actor.initPosRot.pos.x;
    this->actor.posRot.pos.z = (Math_CosS(this->actor.shape.rot.y) * cos60) + this->actor.initPosRot.pos.z;

    if (this->bodyCollider.base.acFlags & 2) {
        EnKarebaba_SetupDying(this);
        func_80032C7C(globalCtx, &this->actor);
    } else if (this->actor.params == 0) {
        EnKarebaba_SetupUpright(this);
    }
}

void EnKarebaba_Dying(EnKarebaba* this, GlobalContext* globalCtx) {
    static Vec3f zeroVec = { 0.0f, 0.0f, 0.0f };
    s32 i;
    Vec3f position;
    Vec3f rotation;

    Math_StepToF(&this->actor.speedXZ, 0.0f, 0.1f);

    if (this->actor.params == 0) {
        Math_ScaledStepToS(&this->actor.shape.rot.x, 0x4800, 0x71C);
        EffectSsHahen_SpawnBurst(globalCtx, &this->actor.posRot.pos, 3.0f, 0, 12, 5, 1, HAHEN_OBJECT_DEFAULT, 10, NULL);

        if (this->actor.scale.x > 0.005f && ((this->actor.bgCheckFlags & 2) || (this->actor.bgCheckFlags & 8))) {
            this->actor.scale.x = this->actor.scale.y = this->actor.scale.z = 0.0f;
            this->actor.speedXZ = 0.0f;
            this->actor.flags &= ~5;
            EffectSsHahen_SpawnBurst(globalCtx, &this->actor.posRot.pos, 3.0f, 0, 12, 5, 15, HAHEN_OBJECT_DEFAULT, 10,
                                     NULL);
        }

        if (this->actor.bgCheckFlags & 2) {
            Audio_PlayActorSound2(&this->actor, NA_SE_EN_DODO_M_GND);
            this->actor.params = 1;
        }
    } else if (this->actor.params == 1) {
        Math_Vec3f_Copy(&position, &this->actor.posRot.pos);
        rotation.z = Math_SinS(this->actor.shape.rot.x) * 20.0f;
        rotation.x = -20.0f * Math_CosS(this->actor.shape.rot.x) * Math_SinS(this->actor.shape.rot.y);
        rotation.y = -20.0f * Math_CosS(this->actor.shape.rot.x) * Math_CosS(this->actor.shape.rot.y);

        for (i = 0; i < 4; i++) {
            func_800286CC(globalCtx, &position, &zeroVec, &zeroVec, 500, 50);
            position.x += rotation.x;
            position.y += rotation.z;
            position.z += rotation.y;
        }

        func_800286CC(globalCtx, &this->actor.initPosRot.pos, &zeroVec, &zeroVec, 500, 100);
        EnKarebaba_SetupDeadItemDrop(this, globalCtx);
    }
}

void EnKarebaba_DeadItemDrop(EnKarebaba* this, GlobalContext* globalCtx) {
    if (this->actor.params != 0) {
        this->actor.params--;
    }

    if (Actor_HasParent(&this->actor, globalCtx) || this->actor.params == 0) {
        EnKarebaba_SetupDead(this);
    } else {
        func_8002F554(&this->actor, globalCtx, GI_STICKS_1);
    }
}

void EnKarebaba_Retract(EnKarebaba* this, GlobalContext* globalCtx) {
    SkelAnime_Update(&this->skelAnime);
    Math_StepToF(&this->actor.scale.x, 0.005f, 0.0005f);
    this->actor.scale.y = this->actor.scale.z = this->actor.scale.x;

    if (Math_StepToF(&this->actor.posRot.pos.y, this->actor.initPosRot.pos.y + 14.0f, 5.0f)) {
        EnKarebaba_SetupIdle(this);
    }

    this->actor.shape.rot.y += 0x1999;
    EffectSsHahen_SpawnBurst(globalCtx, &this->actor.initPosRot.pos, 3.0f, 0, 12, 5, 1, HAHEN_OBJECT_DEFAULT, 10, NULL);
}

void EnKarebaba_Dead(EnKarebaba* this, GlobalContext* globalCtx) {
    SkelAnime_Update(&this->skelAnime);

    if (this->actor.params != 0) {
        this->actor.params--;
    }
    if (this->actor.params == 0) {
        EnKarebaba_SetupRegrow(this);
    }
}

void EnKarebaba_Regrow(EnKarebaba* this, GlobalContext* globalCtx) {
    f32 scaleFactor;

    this->actor.params++;
    scaleFactor = this->actor.params * 0.05f;
    Actor_SetScale(&this->actor, 0.005f * scaleFactor);
    this->actor.posRot.pos.y = this->actor.initPosRot.pos.y + (14.0f * scaleFactor);

    if (this->actor.params == 20) {
        this->actor.flags &= ~0x10;
        this->actor.flags |= 5;
        Actor_ChangeType(globalCtx, &globalCtx->actorCtx, &this->actor, ACTORTYPE_ENEMY);
        EnKarebaba_SetupIdle(this);
    }
}

void EnKarebaba_Update(Actor* thisx, GlobalContext* globalCtx) {
    s32 pad;
    EnKarebaba* this = THIS;
    f32 height;

    this->actionFunc(this, globalCtx);

    if (this->actionFunc != EnKarebaba_Dead) {
        if (this->actionFunc == EnKarebaba_Dying) {
            Actor_MoveForward(&this->actor);
            func_8002E4B4(globalCtx, &this->actor, 10.0f, 15.0f, 10.0f, 5);
        } else {
            func_8002E4B4(globalCtx, &this->actor, 0.0f, 0.0f, 0.0f, 4);
            if (this->boundFloor == NULL) {
                this->boundFloor = this->actor.floorPoly;
            }
        }
        if (this->actionFunc != EnKarebaba_Dying && this->actionFunc != EnKarebaba_DeadItemDrop) {
            if (this->actionFunc != EnKarebaba_Regrow && this->actionFunc != EnKarebaba_Grow) {
                CollisionCheck_SetAT(globalCtx, &globalCtx->colChkCtx, &this->headCollider.base);
                CollisionCheck_SetAC(globalCtx, &globalCtx->colChkCtx, &this->bodyCollider.base);
            }
            CollisionCheck_SetOC(globalCtx, &globalCtx->colChkCtx, &this->headCollider.base);
            Actor_SetHeight(&this->actor, (this->actor.scale.x * 10.0f) / 0.01f);
            height = this->actor.initPosRot.pos.y + 40.0f;
            this->actor.posRot2.pos.x = this->actor.initPosRot.pos.x;
            this->actor.posRot2.pos.y = CLAMP_MAX(this->actor.posRot2.pos.y, height);
            this->actor.posRot2.pos.z = this->actor.initPosRot.pos.z;
        }
    }
}

void EnKarebaba_DrawCenterShadow(EnKarebaba* this, GlobalContext* globalCtx) {
    MtxF mf;

    OPEN_DISPS(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1013);

    func_80094044(globalCtx->state.gfxCtx);

    gDPSetPrimColor(POLY_XLU_DISP++, 0, 0, 0, 0, 0, 255);
    func_80038A28(this->boundFloor, this->actor.initPosRot.pos.x, this->actor.initPosRot.pos.y,
                  this->actor.initPosRot.pos.z, &mf);
    Matrix_Mult(&mf, MTXMODE_NEW);
    Matrix_Scale(0.15f, 1.0f, 0.15f, MTXMODE_APPLY);
    gSPMatrix(POLY_XLU_DISP++, Matrix_NewMtx(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1029),
              G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
    gSPDisplayList(POLY_XLU_DISP++, D_04049210);

    CLOSE_DISPS(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1034);
}

void EnKarebaba_Draw(Actor* thisx, GlobalContext* globalCtx) {
    static Color_RGBA8 black = { 0, 0, 0, 0 };
    static Gfx* dLists[] = { D_06001330, D_06001628, D_06001828 };
    static Vec3f zeroVec = { 0.0f, 0.0f, 0.0f };
    EnKarebaba* this = THIS;
    s32 i;
    s32 numDLists;
    f32 scale;

    OPEN_DISPS(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1056);

    func_80093D18(globalCtx->state.gfxCtx);

    if (this->actionFunc == EnKarebaba_DeadItemDrop) {
        if (this->actor.params > 40 || (this->actor.params & 1)) {
            Matrix_Translate(0.0f, 0.0f, 200.0f, MTXMODE_APPLY);
            gSPMatrix(POLY_OPA_DISP++, Matrix_NewMtx(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1066),
                      G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
            gSPDisplayList(POLY_OPA_DISP++, D_06003070);
        }
    } else if (this->actionFunc != EnKarebaba_Dead) {
        func_80026230(globalCtx, &black, 1, 2);
        SkelAnime_DrawOpa(globalCtx, this->skelAnime.skeleton, this->skelAnime.jointTable, NULL, NULL, NULL);
        Matrix_Translate(this->actor.posRot.pos.x, this->actor.posRot.pos.y, this->actor.posRot.pos.z, MTXMODE_NEW);

        if ((this->actionFunc == EnKarebaba_Regrow) || (this->actionFunc == EnKarebaba_Grow)) {
            scale = this->actor.params * 0.0005f;
        } else {
            scale = 0.01f;
        }

        Matrix_Scale(scale, scale, scale, MTXMODE_APPLY);
        Matrix_RotateRPY(this->actor.shape.rot.x, this->actor.shape.rot.y, 0, MTXMODE_APPLY);

        if (this->actionFunc == EnKarebaba_Dying) {
            numDLists = 2;
        } else {
            numDLists = 3;
        }

        for (i = 0; i < numDLists; i++) {
            Matrix_Translate(0.0f, 0.0f, -2000.0f, MTXMODE_APPLY);
            gSPMatrix(POLY_OPA_DISP++, Matrix_NewMtx(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1116),
                      G_MTX_LOAD | G_MTX_NOPUSH | G_MTX_MODELVIEW);
            gSPDisplayList(POLY_OPA_DISP++, dLists[i]);

            if (i == 0 && this->actionFunc == EnKarebaba_Dying) {
                Matrix_MultVec3f(&zeroVec, &this->actor.posRot2.pos);
            }
        }

        func_80026608(globalCtx);
    }

    func_80026230(globalCtx, &black, 1, 2);
    Matrix_Translate(this->actor.initPosRot.pos.x, this->actor.initPosRot.pos.y, this->actor.initPosRot.pos.z,
                     MTXMODE_NEW);

    if (this->actionFunc != EnKarebaba_Grow) {
        scale = 0.01f;
    }

    Matrix_Scale(scale, scale, scale, MTXMODE_APPLY);
    Matrix_RotateY(this->actor.initPosRot.rot.y * (M_PI / 0x8000), MTXMODE_APPLY);
    gSPMatrix(POLY_OPA_DISP++, Matrix_NewMtx(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1144),
              G_MTX_LOAD | G_MTX_NOPUSH | G_MTX_MODELVIEW);
    gSPDisplayList(POLY_OPA_DISP++, D_060010F0);

    if (this->actionFunc == EnKarebaba_Dying) {
        Matrix_RotateRPY(-0x4000, (s16)(this->actor.shape.rot.y - this->actor.initPosRot.rot.y), 0, MTXMODE_APPLY);
        gSPMatrix(POLY_OPA_DISP++, Matrix_NewMtx(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1155),
                  G_MTX_LOAD | G_MTX_NOPUSH | G_MTX_MODELVIEW);
        gSPDisplayList(POLY_OPA_DISP++, D_06001828);
    }

    func_80026608(globalCtx);

    CLOSE_DISPS(globalCtx->state.gfxCtx, "../z_en_karebaba.c", 1163);

    if (this->boundFloor != NULL) {
        EnKarebaba_DrawCenterShadow(this, globalCtx);
    }
}
