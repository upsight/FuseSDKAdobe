package com.fuse.ane.callback;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import android.app.Activity;

//import com.fusepowered.fuseapi.FuseAPI;
import com.fusepowered.util.ChatMessage;
import com.fusepowered.util.FuseAcceptFriendError;
import com.fusepowered.util.FuseAddFriendError;
import com.fusepowered.util.FuseAttackErrors;
import com.fusepowered.util.FuseEnemiesListError;
import com.fusepowered.util.FuseGameDataCallback;
import com.fusepowered.util.FuseChatError;
import com.fusepowered.util.FuseFriendsListError;
import com.fusepowered.util.FuseGameDataError;
import com.fusepowered.util.FuseLoginError;
import com.fusepowered.util.FuseMailError;
import com.fusepowered.util.FuseRejectFriendError;
import com.fusepowered.util.FuseRemoveFriendError;
import com.fusepowered.util.GameKeyValuePairs;
import com.fusepowered.util.Mail;
import com.fusepowered.util.Player;
import com.fusepowered.util.UserTransactionLog;
import com.fuse.ane.AirFuseAPI.AirFuseAPIExtension;


public class MessageCallback extends FuseGameDataCallback{

	private Activity activity;

	public MessageCallback(Activity activity) {
		this.activity = activity;
	}
	
	@Override
	public void callback() {
		logCallback("Fuse Game Call Back Called");
	}

	@Override
	public void accountLoginComplete(int arg0, String arg1) {
		logCallback("Account Login Complete");
	}

	@Override
	public void notificationAction(String arg0) {
		logCallback("Notification Action");
	}

	@Override
	public void sessionLoginError(FuseLoginError arg0) {
		AirFuseAPIExtension.dispatch("SessionStartError", String.valueOf(arg0.getErrorCode()));
	}

	@Override
	public void sessionStartReceived() {
		AirFuseAPIExtension.dispatch("SessionStartReceived", "2");		
	}

	@Override
	public void timeUpdated(int timestampInSeconds) {
		long ms = (long)1000 * timestampInSeconds;
		Date d = new Date(ms);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy MM dd HH:mm:ss");
		logCallback(new StringBuilder("Time Updated: ").append(sdf.format(d)).append(" UTC").toString());
	}

	public void rewardRedeemed(int incentiveId, int amount, String rewardId, String rewardName) {
		//FuseAPI.rewardRedemptionConfirmation(incentiveId);
		logCallback("Reward ID: " + rewardId + " Reward Name: " + rewardName + " Amount: " + amount);
	}

	@Override
	public void incentiveActionCompletedStatus(String status) {
		logCallback("Incentive Action Completed Status: " + status );
	}

	@Override
	public void chatListError(final FuseChatError errorCode) {
		logCallback("Chat list error: errorCode[" + errorCode + "]");
	}

	@Override
	public void chatListReceived(ArrayList<ChatMessage> messages, String fuseId) {
		StringBuilder buf = new StringBuilder("Chat list received: count[");
		buf.append(messages.size()).append("] fuse_id[").append(fuseId).append("]");
		for (ChatMessage message : messages) {
			buf.append("   Message: ").append(message.toString());
		}
		logCallback(buf.toString());
	}

	@Override
	public void friendAccepted(String fuseId, final FuseAcceptFriendError error) {
		logCallback("Friend accepted: fuseId[" + fuseId + "] errorCode[" + error + "]");
	}

	@Override
	public void friendAdded(String fuseId, final FuseAddFriendError error) {
		logCallback("Friend added: fuseId[" + fuseId + "] errorCode[" + error + "]");
	}

	@Override
	public void friendRejected(String fuseId, final FuseRejectFriendError error) {
		logCallback("Friend rejected: fuseId[" + fuseId + "] errorCode[" + error + "]");
	}

	@Override
	public void friendRemoved(String fuseId, final FuseRemoveFriendError error) {
		logCallback("Friend removed: fuseId[" + fuseId + "] errorCode[" + error + "]");
	}

	@Override
	public void friendsListError(final FuseFriendsListError error) {
		logCallback("Friend list error: errorCode[" + error + "]");
	}

	@Override
	public void friendsListUpdated(ArrayList<Player> players) {
		StringBuilder buf = new StringBuilder("Friend list updated: count[");
		buf.append(players.size()).append("]");
		for (Player player : players) {
			buf.append("   Friend: ").append(player.toString());
		}
		logCallback(buf.toString());
	}

	@Override
	public void gameConfigurationReceived() {
		AirFuseAPIExtension.dispatch("AppConfigurationReceived", "2");
	}

	private void logCallback(String msg) {
		//AirFuseAPIExtension.log(msg);
	}

    @Override
    public void mailListReceived(ArrayList<Mail> mailMessages, String fuse_id) {
        StringBuilder buf = new StringBuilder("Mail list received: count[");
        buf.append(mailMessages.size()).append("]");
        for (Mail mail : mailMessages) {
            buf.append("   Mail: ").append(mail.toString());
        }
        logCallback(buf.toString());
    }

    @Override
    public void mailListError(FuseMailError error) {
        logCallback("Mail list error: [" + error + "]");
    }

    @Override
    public void mailAcknowledged(int messageId, String fuse_id, int requestID) {
        logCallback(String.format("Mail acknowledged: messageId[%d] fuseId[%s] requestID[%d]", messageId, fuse_id, requestID));
    }

    @Override
    public void mailError(FuseMailError error, int requestID) {
        logCallback("Mail error: [" + error + "]");
    }
    
    @Override
    public void adAvailabilityResponse(int available, int error){
    	
    }

	@Override
	public void attackRobberyLogError(FuseAttackErrors arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void attackRobberyLogReceived(ArrayList<UserTransactionLog> arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void enemiesListError(FuseEnemiesListError arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void enemiesListResult(ArrayList<Player> arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void gameDataError(FuseGameDataError arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void gameDataError(FuseGameDataError arg0, int arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void gameDataReceived(String arg0, GameKeyValuePairs arg1) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void gameDataReceived(String arg0, GameKeyValuePairs arg1, int arg2) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void gameDataSetAcknowledged(int arg0) {
		// TODO Auto-generated method stub
		
	}


}
